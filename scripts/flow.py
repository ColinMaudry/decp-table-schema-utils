from dataflows import Flow, load, dump_to_path, dump_to_zip, printer, add_metadata
# from dataflows import sort_rows, filter_rows, find_replace, delete_fields, set_type, validate, unpivot
import re
import ast
import simplejson as json

def simple_json():
    flow = Flow(
        # Load inputs
        load('tmp/withAnomalies.json', format = 'json', property = 'marches'),
        clean_data

        # Process them (if necessary)
        # Save the results
        # add_metadata(name='simple_json', title='''simple.json''')
    )
    flow.process()

def clean_data(row) :
    if row["objet"] :
        row["objet"] = re.sub(' +', ' ', row["objet"].replace("\\n"," "))

# def detect_anomalies(row) :


if __name__ == '__main__':
    simple_json()
