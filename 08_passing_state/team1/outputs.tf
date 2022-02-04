output db_address {
  value = aws_db_instance.postgresdb.address
}

output  db_port {
  value = aws_db_instance.postgresdb.port
}