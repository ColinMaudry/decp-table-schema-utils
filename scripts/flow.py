from dataflows import Flow, load, dump_to_path, dump_to_zip, printer, add_metadata
from dataflows import sort_rows, filter_rows, find_replace, delete_fields, set_type, validate, unpivot

import subprocess

def decp_processing():
    flow = Flow(
        load("json.csv"),
        set_type("donneesActuelles", type="boolean"),
        set_type("acheteur.id", type="string"),
        set_type("titulaire.id", type="string"),
        set_type("codeCPV", type="string"),
        set_type("lieuExecution.code", type="string"),
        # donnees_actuelles,
        sort_rows('seq', resources = 0, reverse = True),
        donnees_actuelles,
        dump_to_path("decp")

    )
    flow.process()


# def detect_anomalies(row) :

def json_to_csv() :
     subprocess.call(['scripts/decpJson-to-csv.sh','decp.json'])

def donnees_actuelles(rows) :
    print()
    prevRootId = ""
    donneesActuelles = False

    for row in rows :
        if row['rootId'] != prevRootId :
            donneesActuelles = True
            prevSeq = row['seq']
            prevRootId = row['rootId']

        elif row['rootId'] == prevRootId and row['seq'] != prevSeq :
            donneesActuelles = False
            prevSeq = row['seq']

        row['donneesActuelles'] = donneesActuelles
        yield row

if __name__ == '__main__':
    json_to_csv()
    decp_processing()
