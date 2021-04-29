from dataflows import Flow, load, dump_to_path, dump_to_zip, printer, add_metadata, update_resource
from dataflows import sort_rows, filter_rows, find_replace, delete_fields, set_type, validate, unpivot
import subprocess
from datapackage_to_datasette import datapackage_to_datasette, DataImportError

def decp_processing():
    flow = Flow(
        load("decp.csv"),
        set_type("donneesActuelles", type="boolean"),
        set_type("acheteur.id", type="string"),
        set_type("titulaire.id", type="string"),
        set_type("codeCPV", type="string"),
        set_type("lieuExecution.code", type="string"),
        # update_resource(0, '{"name": "decp"}'),
        sort_rows('{rootId}:{seq}', resources = 0, reverse = True),
        donnees_actuelles,
        delete_fields(["rootId","seq"], resources= 0, regex=False),
        dump_to_path("decp")

    )
    flow.process()


def json_to_csv() :
     subprocess.call(['scripts/decpJson-to-csv.sh','decp.json'])

def donnees_actuelles(rows) :
    prevRootId = ""
    donneesActuelles = ""
    prevSeq = 0

    for row in rows :
        if row['rootId'] != prevRootId :
            donneesActuelles = "oui"
            prevSeq = row['seq']
            prevRootId = row['rootId']

        elif row['rootId'] == prevRootId and row['seq'] != prevSeq :
            donneesActuelles = "non"
            prevSeq = row['seq']

        row['donneesActuelles'] = donneesActuelles
        yield row

def load_to_sqlite() :
    try:
        datapackage_to_datasette(
            'decp/decp.db',
            'decp/datapackage.json',
            '/dev/null',
            write_mode='replace'
        )
    except DataImportError:
        raise

if __name__ == '__main__':
    json_to_csv()
    decp_processing()
    load_to_sqlite()
