resource "aws_qldb_ledger" "bert-afblijven" {
  # (resource arguments)
    deletion_protection = true
    name                = "bert-afblijven"
    tags                = {}
    tags_all            = {}
}