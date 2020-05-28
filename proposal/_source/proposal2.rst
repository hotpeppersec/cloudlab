.. graphviz::
   :caption: Project Directory
   :align: center

   digraph folders {
      "cloudlab" [shape=folder];
      "python" [shape=folder];
      "docker" [shape=folder];
      "terraform" [shape=folder];
      "Makefile" [shape=rect];
      "docker-compose.yml" [shape=rect];
      "Dockerfile" [shape=rect];

      "cloudlab" -> "python";
      "cloudlab" -> "terraform";
      "cloudlab" -> "docker";
      "cloudlab" -> "Makefile";
      "docker" -> "Dockerfile";
      "docker" -> "docker-compose.yml";
   }
