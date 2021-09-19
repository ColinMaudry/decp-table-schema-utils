def getRootId(data):
    if ((data.id[-2:] | tonumber?) == (data.modifications | length))
    then
    data.id[:((data.id |length) - 2)]
    else
    data.id
    end;
def toDateEpoch(date):
    date | . + "T00:00:00Z" | fromdateiso8601
    ;

def fixDate(date):
    date |
    gsub("[\\+\\-]\\d\\d\\:\\d\\d$";"") |
    gsub("^0202\\-|0200\\-|0020\\-|220\\-";"2020-") |
    gsub("^0219\\-|0209\\-|0019\\-";"2019-")
    ;
def getDate(date;other):
    fixDate(date) as $fixedDate |
    fixDate(other) as $fixedOther |
    toDateEpoch($fixedDate) as $dateEpoch |
    toDateEpoch($fixedOther) as $otherEpoch |
    if ($dateEpoch < ($now | fromdateiso8601)) then
        $fixedDate
    elif  ($otherEpoch < ($now | fromdateiso8601)) then
        $fixedOther
    else
        empty
    end;

[.marches[] | select(._type == "Marché" and (.titulaires? | length) > 0)] and (.dateNotification | length >= 9) | map(
. as $m |

(reduce .modifications[] as $mod ({};
{
    "objetModification": ($mod.objetModification // .objetModification),
    "dureeMois": ($mod.dureeMois // .dureeMois),
    "montant": ($mod.montant // .montant),
    "titulaires": ($mod.titulaires // .titulaires),
    "datePublicationDonneesModification": ($mod.datePublicationDonneesModification // .datePublicationDonneesModification)
})) as $modifications
     |
 ($modifications.titulaires // .titulaires) | map (
    {
        "id": ($m.id? | tostring),
        "rootId": getRootId({"id":($m.uid? | tostring),"modifications": $m.modifications?}),
        "seq": $m.modifications | length,
        "uid": ($m.uid? | tostring),
        "acheteur.id": ($m.acheteur.id? | tostring),
        "acheteur.nom": $m.acheteur.nom?,
        "nature": $m.nature?,
        "objet": ($m.objet? | gsub("\\\n"; " ")),
        "codeCPV": $m.codeCPV?,
        "procedure": $m.procedure?,
        "lieuExecution.code": $m.lieuExecution.code?,
        "lieuExecution.typeCode": $m.lieuExecution.typeCode?,
        "lieuExecution.nom": $m.lieuExecution.nom?,
        "dureeMois": ($modifications.dureeMois // $m.dureeMois?) | round,
        "dateNotification": getDate($m.dateNotification?;($modifications.datePublicationDonneesModification // $m.datePublicationDonnees)),
        "datePublicationDonnees": getDate(($modifications.datePublicationDonneesModification // $m.datePublicationDonnees);$m.dateNotification?),
        "montant": $m.montant?,
        "formePrix": $m.formePrix?,
        "titulaire.id": (.id? | tostring),
        "titulaire.typeIdentifiant": .typeIdentifiant?,
        "titulaire.denominationSociale": .denominationSociale?,
        "objetModification": $modifications.objetModification,
        "source": $m.source?,
        #"anomalies": ($m.anomalies | length)
        "donneesActuelles": "non",
        #"modifications": $modifications,
        "anomalies": (if ($m.anomalies) then $m.anomalies | join(";") else "" end)
    }
)
|
map ( [to_entries[] | .value]) | .[]
)
| .[]
