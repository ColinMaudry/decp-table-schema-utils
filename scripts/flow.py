from dataflows import Flow, load, dump_to_path, sort_rows, delete_fields, set_type, duplicate, deduplicate, set_primary_key, concatenate
import subprocess
from datapackage_to_datasette import datapackage_to_datasette, DataImportError

def decp_processing():
    flow = Flow(

    # Chargement du CSV suite à la conversion depuis JSON
        load("decp.csv"),
        set_type("acheteur.id", type="string"),
        set_type("titulaire.id", type="string"),
        set_type("codeCPV", type="string"),
        set_type("lieuExecution.code", type="string"),

    # Tri par rootId et seq pour préparer à la création de donneesActuelles
        sort_rows('{rootId}:{seq}', resources = 0, reverse = True),
        donnees_actuelles,

    # rootId et seq peuvent maintenant être supprimés
        delete_fields(["rootId","seq"], resources= 0, regex = False),
        sort_rows('{datePublicationDonnees}', resources = 0, reverse = True),

    # Nouvelle table dédiée aux marchés, sans données sur les titulaires
        print("Création de la table dédiée aux marchés..."),
        duplicate(source="decp", target_name="sans-titulaires", target_path="sans-titulaires.csv", duplicate_to_end=True),
        delete_fields(["titulaire.id","titulaire.denominationSociale"], resources = "sans-titulaires", regex = False),
        set_primary_key(["uid"], resources = "sans-titulaires"),
        deduplicate(),

    # Chargement des précédentes DECP au format CSV, pour extraction des nouvelles données
        # print("Téléchargement des données tabulaires précédentes..."),
        # load("https://decp.info/db/decp.csv?_size=max&_dl=1", name="previous-decp"),
        # set_type("acheteur.id", type="string"),
        # set_type("titulaire.id", type="string"),
        # set_type("codeCPV", type="string"),
        # set_type("lieuExecution.code", type="string"),
        # delete_fields(["rowid"], resources="previous-decp", regex=False),
        # #print("Fusion des données tabulaires précédentes et des données d'aujourd'hui..."),
        # concatenate({},target={"name": "decp-titulaires","path": "decp-titulaires.csv"},resources=["decp","previous-decp"]),

    # Chargement des précédentes données dédiées aux titulaires
        print("Chargement des données titulaires..."),
        load("decp-titulaires.csv", name="decp-titulaires"),
        delete_fields(["siret"], resources="decp-titulaires", regex=False),
        set_type("acheteur.id", type="string"),
        set_type("titulaire.id", type="string"),
        set_type("codeCPV", type="string"),
        set_type("lieuExecution.code", type="string"),
        set_type("departement", type="string"),
        set_type("codeAPE", type="string"),
        print("Enregistrement des données sur le disque..."),
        dump_to_path("decp")
    )
    flow.process()


def json_to_csv() :
     subprocess.call(['scripts/decpJson-to-csv.sh','test.json'])

def donnees_actuelles(rows) :
    print("Distinction des données actuelles et des données anciennes...")
    prevRootId = ""
    donneesActuelles = ""
    prevSeq = 0

    for row in rows :
        if row['rootId'] != prevRootId :
            donneesActuelles = 'oui'
            prevSeq = row['seq']
            prevRootId = row['rootId']

        elif row['rootId'] == prevRootId and row['seq'] != prevSeq :
            donneesActuelles = 'non'
            prevSeq = row['seq']

        row['donneesActuelles'] = donneesActuelles
        yield row

def load_to_sqlite() :
    try:
        datapackage_to_datasette(
            'datasette/decp.sqlite',
            'decp/datapackage.json',
            '/dev/null',
            write_mode='replace'
        )
    except DataImportError:
        raise

if __name__ == '__main__':
    print("Conversion JSON vers CSV, et détection des anomalies...")
    json_to_csv()
    print("Chargement du CSV, tri...")
    decp_processing()
    print("Chargement dans SQLite et création des métadonnées datasette...")
    load_to_sqlite()
