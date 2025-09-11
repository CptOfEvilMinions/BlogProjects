data "databricks_current_user" "me" {}

resource "databricks_notebook" "ddl" {
  source = "${path.module}/../notebooks/create_bronze_tables.ipynb"
  path   = "${data.databricks_current_user.me.home}/${replace(var.project_prefix, "-", "_")}"
}
