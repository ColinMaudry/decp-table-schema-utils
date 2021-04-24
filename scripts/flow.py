from dataflows import Flow, load, dump_to_path, dump_to_zip, printer, add_metadata
from dataflows import sort_rows, filter_rows, find_replace, delete_fields, set_type, validate, unpivot
import re
import ast
import simplejson as json
import pandas as pd
import pyjq as jq
import subprocess

dataaa = [
    {
        'id': 1
    }
]

# def action_package(package) :
#     print(package.pkg.descriptor["resources"][0])

# def donnees_actuelles(rows) :
#     print(rows)
#     return rows


def simple_json():
    flow = Flow(
        load("json.csv"),
        set_type("donneesActuelles", type="boolean"),
        set_type("acheteur.id", type="string"),
        set_type("titulaire.id", type="string"),
        set_type("codeCPV", type="string"),
        set_type("lieuExecution.code", type="string"),
        # donnees_actuelles,
        sort_rows('rootId', resources = 0, reverse = True),
        dump_to_path("decp")

    )
    flow.process()


# def detect_anomalies(row) :

def json_to_csv() :
     subprocess.call(['scripts/decpJson-to-csv.sh','decp.json'])


if __name__ == '__main__':
    json_to_csv()
    simple_json()
