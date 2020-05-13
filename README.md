# Flask App With Docker

*Para visualizar o preview do .md no vs code, utilize Ctrl+Shift+V*

### Construir Imagem 

```sh
docker build -t flask_app .
```

### Criar Container a partir da Imagem

```sh
docker run --rm -d -p 8000:80 -v $(pwd):/main:z --name my_docker_flask flask_app
```

### Entrar no Container

```sh
docker exec -it my_docker_flask bash
```

### Comando para treinamento (requisição GET)

URL_APP:8000/train

### Comando para predição (requisição POST)

curl -i -X POST -H 'Content-Type: application/json' -d '[  {"Age": 85, "Sex": "male", "Embarked": "S"}, {"Age": 24, "Sex": "female", "Embarked": "C"},{"Age": 3, "Sex": "male", "Embarked": "C"}, {"Age": 21, "Sex": "male", "Embarked": "S"}]' URL_APP:8000/predict

### Projeto baseado em:

Flask API for training and predicting using scikit learn models. Link: https://github.com/amirziai/sklearnflask/


# Docker

Cria um container a partir da imagem indicada. Quando não houver a imagem no PC, o docker daemon faz o docker pull automaticamente.

```sh
docker run ubuntu
```

Atributos:

- -d # detached (não trava o terminal na execução)
- -p # faz o attach da porta (Computador:Container) Ex: 8000:80
- --rm # mata o container no final da execução automaticamente (não vai ficar pausando, então não vai aparecer no 'docker ps -a')
- -it # entra no terminal do container depois de executá-lo
- <qualquer comando> # executa o comando depois de criar o container Ex: docker run node npm start (executa uma app node)
- --volume ou -v # adiciona um volume ao docker, ex: um banco de dados docker, deve persistir as informações em um storage físico para que ao morrer, o próximo docker utilize as mesmas infomrações. Quando inicia um novo container, o volume é copiado para dentro do container, então podemos usar esse comando para copiar volumes para dentro do container também (ex: docker run -v "C:\projetos\projetoEmNode:/projetos/node" -> nesse caso estou copiando o volume que está antes do ":" para a pasta /projetos/node do container. Supondo que eu não tenho node instalado no meu computador, eu consigo rodar o código node sem precisar instalar node na minha máquina. Você pode alterar os arquivos da aplicação e ele irá atualizar o docker em tempo real, pois ele está olhando para a pasta do seu computador)
- --name # dá um nome ao seu container
- -a, --attach # atrela o terminal do seu computador ao terminal do container (Parecido com o -it)
- -e # Adiciona uma variável de ambiente dentro do seu container (ex: docker run -e AUTHOR="Gui")
- -w # Qual diretório você quer que o container inicie. Ex: docker run -w "/projeto/node" node npm start
- --network # Especifica uma rede para o container docker

Faz o pull de uma imagem do Docker Hub/Docker Store

```sh
docker pull hello-world
```

Envia sua imagem para disponibilizá-la no dockerhub

```sh
docker push [nome da imagem]
```

Lista todos os containers que estão ativos no momento.

```sh
docker ps
```

Atributos:
- -a # lista todos os containers (ativos e inativos)
- -q # retorna só o ID dos containers


Lista todas as imagens baixadas no computador.


```sh
docker images
```


Manipula as imagens instaladas


```sh
docker image
```

Atributos:
- ls # lista todos as imagens
- prune # mata todas as imagens baixadas

Cria uma Imagem docker a partir dos comandos contidos na Dockerfile (ou em outro, quando especificado)


```sh
docker build
```

Atributos:
- -q ou --quiet # silencia os outputs do build no terminal
- -t # nome na tag (precisa estar no formato name:tag) Ex: '-t flask_app .' irá gerar uma imagem flask_app
- -f ou --file # especifica o nome do Dockerfile para o build (Se você colocou Dockerfile como nome do arquivo, não precisa especificar)
- --pull # sempre tenta baixar uma nova versão da imagem
- -o # output destination (format: type=local,dest=path)
- --build-arg # adiciona argumentos em tempo de build

Entra dentro do terminal do container

```sh
docker exec -it <nome do container> <nome do terminal, ex:bash>
```

Starta um container que está parado (você pode visualizar os containers parados no docker ps -a)

```sh
docker start <id>
```

Atributos:

- -a, --attach # atrela o terminal do seu computador ao terminal do container (Parecido com o -it)
- -i, --interactive # permite que você escreva no terminal do container que está atrelado, ou seja, utilizar -a e -i juntos para iniciar e entrar no terminal do container

Remove os containers do seu computador

```sh
docker rm <id>
```

Atributos:

- -f, --force # Força o stop do container e remove ele.

Remove TODOS containers parados no computador

```sh
docker container prune
```

Remove images do seu computador

```sh
docker rmi <nome> ou <id>
```

Para pausar um container

```sh
docker stop [ID]
```

Atributos:
- -t # quantos segundos esperar para pausar antes de dar kill (default 10segundos)


Para encerrar execução (forçando) de um container

```sh
docker kill [ID]
```

Para ver mapeamento de portas de um container

```sh
docker port [ID]
```

Atrelando comandos no docker (Ex: pare os containers que o command 'docker ps -q' me retorna)

```sh
docker stop $(docker ps -q) 
```

Ou nesse exemplo mais complexo. Nesse comando eu quero rodar e desenvolver uma aplicação node sem instalá-la na minha máquina utilizando docker. Então vou mapear a porta 8080 do meu computador para a porta 3000 do meu container (onde vai rodar minha app web), vou mapear o volume da minha pasta atual "$(pwd)" (o pwd no linux é o caminho atual do terminal) para a pasta "/var/www" do container, vou falar para o container iniciar no diretório "/var/www" com o comando -w e vou criar a partir da imagem "node" e vou executar o comando npm start

```sh
docker run -p 8080:3000 -v "$(pwd):/var/www" -w "/var/www" node npm start
```

Retorna informações do container (Ex: "Mounts", onde está mapeado o volume do -v)

```sh
docker inspect [ID]
```

Faz Login na sua conta do docker, para publicar imagens por exemplo

```sh
docker login
```

Por default, o docker coloca todos os containers numa rede default já configurada e todos eles podem se enxergar. Porém na rede default do docker, você não pode dar um DNS (nome virtual) para o container e abstrair o IP. O problema disso é que quando o container for recriado, ele vai mudar de IP e isso vai fazer com que os containers percam a referência à aquele IP. Quando você cria a sua própria rede, você pode atribuir nome aos containers.

Criando sua própria rede. Você precisa especificar um driver para a sua rede, geralmente é o bridge

```sh
docker network create --driver bridge [NomeDaRede]
```

Lista as redes criadas.

```sh
docker network ls
```

Cria os container baseado no docker-compose.yml

```sh
docker-compose
```

Atributos:
- build # builda os container e baixa as imagens
- up # sobre os containers que você tem especificados no arquivo
- up [nome1] [nome2] ... # sobe os containers que você especificar depois do comando
- down # mata os containers que ele subiu no docker-compose up
- -d # sobe os containers sem travar o terminal
- ps # lista os containers que estão rodando no momento
- restart # reinicia os containers, equivalente a um up e um downs

# Docker Swarm

Para simular o docker swarm, necessitamos de várias máquinas separadas, para simular o ambiente de clustering, e orquestração interservidor. É Necessário instalar o Docker-Machine, para criação de VM's, e utilizar o Hyper-V como driver dessas máquinas (pode usar também o Virtualbox, mas concomitantemente com o Hyper-V ele falha)

### Docker Machine

Cria uma máquina virtual com o docker configurado.

```sh
docker-machine create -d <driver> <vm_name>
```

Atributos:

- -d ou --driver # Seleciona o driver que essa máquina virtual irá utilizar (hyperv ou virtualbox) **Importante**: Para utilizar o Hyper-V como driver da vm é necessário criar um *Virtual Switch Manager*. **Antes de criar, tente o comando abaixo com o Default Switch**. Caso não funcione, siga os passos abaixo para fazer a instalação (**caso não funcione, siga o tutorial https://rominirani.com/docker-machine-windows-10-hyper-v-troubleshooting-tips-367c1ea73c24**)

    - Abra o Hyper-V Manager como **Adminstrador**
    - Clique no Hyper-V Manager (Provavelmente com o nome da máquina)
    - Vá em Actions > Virtual Switch Manager
    - Selecione External e clique em Create Virtual Switch
    - Selecion External Network e a opção com 'Ethernet Connection'
    - Dê um nome para sua Virtual Switch

Criando vms com a virtual switch do Hyper-V, onde "Default Switch" é o nome do meu switch padrão do Hyper-V e vm1 é o nome da minha máquina virtual

```sh
docker-machine create --driver hyperv --hyperv-virtual-switch "Default Switch" <vm_name>
```

Lista as máquinas virtuais

```sh
docker-machine ls
```

Inicia uma máquina virtual

```sh
docker-machine start <vm_name>
```

Pausa uma máquina virtual

```sh
docker-machine stop <vm_name>
```

Deleta uma máquina virtual

```sh
docker-machine rm <vm_name>
```

Entra na máquina virtual

```sh
docker-machine ssh <vm_name>
```

Inicia o Swarm (cluster) numa docker-machine (master ou manager)

```sh
docker swarm init
```

Atributos:
- --advertise-addr # especifica qual IP essa máquina vai ter

# Kubernetes

- Kubernetes é um cluster que administra e orquestra containers em várias máquinas. Um cluster é um conjunto de máquinas e containers. O kubernetes funciona da seguinte maneira, dentro do cluster, nós temos uma máquina que vai ser o servidor **Master**, onde irão ficar as configurações do kubernetes. Depois nós temos os **Nodes** (ou minions) que são servidores orquestrados pelo master. Nelas estão todas as configurações necessárias para que um Pod funcione. O **Pod** é o menor componente dentro do Kuberneters, é onde estão localizados os containers. Eles são gerenciados pelo Node, que por sua vez, são gerenciados pelo Master. Os **Deployments** (antiga *Replication Controller*)são responsáveis pela replicação e alta escalabiliade dos pods.
- Minikube é um ambiente de teste do Kubernetes, simula a criação de várias máquinas dentro do seu computador
- kubectl é a ferramenta na linha de comando para gerenciar o cluster Kubernetes
- Para definir um container no Kubernetes é preciso definir um Pod
    - Um Pod é a menor unidade de deploy no Kubernetes
    - Um Pod agrupa um ou mais containers que compartilham a mesma interface de rede e sistema de arquivos
    - Um Pod é um objeto no Kubernetes descrito por um arquivo YML
    - O YML do Pod define qual é a imagem, porta, versão, nome entre outras configurações

Iniciar o cluster Minikube

```sh
minikube start
```

Atributos:
- --driver=<driver_name> # Nome do driver que o minikube vai utilizar (hyperv ou virtualbox) **Não é necessário todas as vezes**
- --kubernetes-version="v1.16" # Especifica uma versão específica

Status do cluster Minikube

```sh
minikube status
```

Pausa o cluster Minikube

```sh
minikube stop
```

Acessa o dashboard do cluster Minikube

```sh
minikube dashboard
```

Deleta o cluster Minikube

```sh
minikube delete
```

Atributos:
- --all # remover todos os clusters e perfis

Para conectar-se no nó **master** do cluster Minikube

```sh
minikube ssh
```

Cria um pod a partir de um yml dentro do cluster:

```sh
kubectl create -f <nome_do_arquivo>
```

Deleta um pod a partir de um yml dentro do cluster:

```sh
kubectl delete -f <nome_do_arquivo>
```
ou 

```sh
kubectl delete <type> <name>
```

Atributos:
- type # tipo do que será deletado (deployment, pod, service)
- name # nome dele no minikube (pode ser recuperado a partir do 'kubectl get pod ou services')

Lista os pods ativos dentro do cluster

```sh
kubectl get pods
```

Detalha informações dos pods ativos dentro do cluster

```sh
kubectl describe pods <optional: pod_name>
```

Lista os nodes ativos dentro do cluster

```sh
kubectl get nodes
```

Lista as informações do serviço criado

```sh
minikube service aplicacao-noticia-servico
```

Atributos:
- --ulr # mostra apenas a url do serviço levantado

Entra no pod ou deployment

```sh
kubectl exec -it <nome_do_pod_ou_deployment> bash
```

Auto escalar os recursos do minikube automaticamente

```sh
kubectl autoscale deployment aplicacao-noticia-deployment
```

Atributos:
- --cpu-percent # quando ultrapassar esse limite de porcentagem da CPU, o autoscaler começa a funcionar
- --min # número mínimo de máquinas (Ex: 1)
- --max # número máximo de máquinas (Ex: 10) ele vai escalar até 10 máquinas para balancear a carga

Verifica se um serviço está sendo autoescalável

```sh
kubectl get hpa
```

Lista todos os parâmetros que podem ser ativados no minikube

```sh
minikube addons list
```

Ativa um parâmetro no minikube

```sh
minikube addons enable <parameter_name>
```