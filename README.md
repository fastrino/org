# RICH-GAN-2019




## Docker 

#### Pulling

```docker pull mrartemev/rich2019```

Built with love from ./Dockerfile 

#### Usage
To run docker image run following code inside repo directory

```docker run --rm -v `pwd`:/home/RICH-GAN --name <name> --runtime nvidia -it -p <port>:8888 <image_name>```

For example:

```docker run --rm -v `pwd`:/workdir --name rich --runtime nvidia -it -p 8888:8888 mrartemev/rich2019```

Running this command will mount docker to your repo directory and execute jupyter notebook command inside your docker.

Open this in your browser to work with repo http://localhost(or yours server-id):8888 (or other chosen <port>). After that, you'll be able to run ipython notebooks in /research


## Data

`./get_data_calibsample.sh`


