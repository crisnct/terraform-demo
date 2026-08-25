resource local_file name1 {
  filename = "explicit.txt"
  content = "This is random String from RP : ${random_string.name2.id}"
  depends_on =  [random_string.name2]
}

resource random_string name2 {
  length  = 1024
}

output "display_random_string" {
  value = random_string.name2.id
}
