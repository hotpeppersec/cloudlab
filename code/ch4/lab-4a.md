## Testing Out Docker (Lab 4a)

Here is a step by step description of how to prepare the creation of
our first container:

* Create the ``devsecops'' folder.
  * When creating folders, note that capitalization matters.
* In that folder, create another folder called ``docker''.
  * Now in the docker folder, create a text file with the name ``Dockerfile''.
  * Copy and paste the example Dockerfile from earlier in this chapter into your text file.
* Also in the docker folder, create a text file with the name ``docker-compose.yml''
  * Copy and paste the example docker-compose.yml file from earlier in this chapter into your second text file.

\justify{}
Here is an example of the BASH shell commands you can use to accomplish
the steps of the exercise. You can substitue vi for your favorite text
editor as needed. Note that typing the ``docker-compose'' command on line
6 will reference the devsecops ``service'' we specified on line 3 of the
docker-compose.yml file.

\justify{}
\begin{mybox}{\thetcbcounter: Create files for Docker,height=3.5cm}
  \lstinputlisting{code/05-containers/create-files.txt}
\end{mybox}

\justify{}
With our files created and populated, we are ready to generate our container based on our specified configuration.

\begin{mybox}{\thetcbcounter: Build from docker-compose.yml}
  docker-compose -f docker/docker-compose.yml build devsecops
\end{mybox}

\justify{}
If all went well, you should now have a shell prompt from ``inside'' the new container. Recall that we set our 
\textbf{WORKDIR} variable to /project in the Dockerfile. Following that example, we now have Dockerfile
and docker-compose.yml in the directory /project/docker, having mounted the project directory from the host machine 
``inside'' the container.
