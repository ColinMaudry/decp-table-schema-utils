from datasette import hookimpl

@hookimpl
def menu_links(datasette, actor):
    return [
        {"href": "https://github.com/ColinMaudry/decp-table-schema", "label": "Documentation des champs"},
        {"href": "https://github.com/ColinMaudry/decp-table-schema-utils", "label": "Code source"}
    ]
