# routes for internet gateway which will be set in public subent
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

# routes for NAT gateway which will be set in private subent
resource "aws_route" "private_nat" {
  count                  = length(var.availability_zones)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
}

#resource "aws_route" "public_peering" {
#  route_table_id            = aws_route_table.public.id
#  destination_cidr_block    = "10.200.0.0/16"
#  vpc_peering_connection_id = var.vpc_peer_connection_id_bered_apne2
#}
#
#resource "aws_route" "private_peering" {
#  count                     = length(var.availability_zones)
#  route_table_id            = element(aws_route_table.private.*.id, count.index)
#  destination_cidr_block    = "10.200.0.0/16"
#  vpc_peering_connection_id = var.vpc_peer_connection_id_bered_apne2
#}
#
