from datasette import hookimpl

@hookimpl
def menu_links(datasette, actor):
    return [
        {"href": "https://teamopendata.org/t/decp-info-les-donnees-de-la-commande-publique-pour-tous-questions-reponses-discussions/2948", "label": "Présentation / FAQ"},
        {"href": "https://github.com/ColinMaudry/decp-table-schema", "label": "Documentation des champs"},
        {"href": "https://github.com/ColinMaudry/decp-table-schema-utils", "label": "Code source"}
    ]
