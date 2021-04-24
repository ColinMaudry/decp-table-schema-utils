def getRootId(data):
    if ((data.id[-2:] | tonumber?) == (data.modifications | length))
    then
    data.id[:((data.id |length) - 2)]
    else
    data.id
    end
    ;
[.marches[] | select(._type == "Marché" and (.titulaires? | length) > 0)] | map(
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
        "dateNotification": $m.dateNotification? | gsub("[\\+\\-]\\d\\d\\:\\d\\d$";""),
        "datePublicationDonnees": ($modifications.datePublicationDonneesModification // $m.datePublicationDonnees) | gsub("[\\+\\-]\\d\\d\\:\\d\\d$";""),
        "montant": $m.montant?,
        "formePrix": $m.formePrix?,
        "titulaire.id": (.id? | tostring),
        "titulaire.typeIdentifiant": .typeIdentifiant?,
        "titulaire.denominationSociale": .denominationSociale?,
        "objetModification": $modifications.objetModification,
        #"anomalies": ($m.anomalies | length)
        "donneesActuelles": 0,
        #"modifications": $modifications,
        "anomalies": (if ($m.anomalies) then $m.anomalies | join(";") else "" end)
    }
)
|
map ( [to_entries[] | .value]) | .[]
)
| .[]
