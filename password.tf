resource "random_password" "non_root" {
  length = var.password_length
  special = false
}
resource "random_password" "root" {
  length = var.password_length
  special = false
}
