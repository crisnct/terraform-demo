resource random_integer name {
  min = 201
  max = 360

    lifecycle{
        #create_before_destroy = true
        #prevent_destroy = true
        ignore_changes = [min]
    }

}
