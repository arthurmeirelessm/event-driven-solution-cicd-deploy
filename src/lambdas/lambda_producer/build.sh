#!/bin/bash

# Definindo o nome da imagem como uma variável de ambiente
IMAGE_NAME="${IMAGE_NAME:-lambdaproducer:test}"
CONTAINER_NAME="${CONTAINER_NAME:-lambdaproducer_container}"

# Passo 1: Verificar se o contêiner existe
EXISTING_CONTAINER=$(docker ps -q -f "name=$CONTAINER_NAME")

if [ -z "$EXISTING_CONTAINER" ]; then
  # Caso não exista, é a primeira vez que estamos criando a imagem e o contêiner
  echo "Primeira vez criando a imagem e o contêiner..."

  # Passo 2: Construir a nova imagem
  echo "Construindo a nova imagem..."
  docker build -t $IMAGE_NAME .

  # Passo 3: Rodar o contêiner com a nova versão
  echo "Rodando o contêiner com a nova versão..."
  docker run -d --rm \
    --name $CONTAINER_NAME \
    -v "$PWD/lambda_function.py":/var/task/lambda_function.py \
    -v "$PWD/other_files":/var/task/other_files \
    -p 9000:8080 \
    $IMAGE_NAME

  echo "Contêiner rodando na porta 9000..."
else
  # Caso o contêiner já exista, vamos atualizar a imagem e o contêiner
  echo "Contêiner existente encontrado. Atualizando imagem e contêiner..."

  # Passo 2: Construir a nova imagem
  echo "Construindo a nova imagem..."
  docker build -t $IMAGE_NAME .

  # Passo 3: Parar e remover o contêiner antigo
  echo "Parando e removendo o contêiner antigo..."
  docker stop $CONTAINER_NAME
  docker rm $CONTAINER_NAME

  # Passo 4: Rodar o contêiner com a nova versão
  echo "Rodando o contêiner com a nova versão..."
  docker run -d --rm \
    --name $CONTAINER_NAME \
    -v "$PWD/lambda_function.py":/var/task/lambda_function.py \
    -v "$PWD/other_files":/var/task/other_files \
    -p 9000:8080 \
    $IMAGE_NAME

  echo "Contêiner rodando na porta 9000..."
fi






EVENT-DRIVEN-SOLUTION-CICD-DEPLOY [WSL: ...]
├── infrastructure
    ├── modules
        ├── cicd
        │   ├── codebuild.tf
        │   ├── codepipeline.tf
        │   ├── iam.tf
        │   └── variables.tf
        ├── ecr
        ├── serverless
        │   ├── iam.tf
        │   ├── serverless_main.tf
        │   └── variables.tf
        ├── shared
        │   ├── outputs.tf
        │   ├── shared_main.tf
        │   └── variables.tf
├── src
│   └── lambda
│       ├── lambda_producer
│       │   ├── events
│       │   ├── other_files
│       │   ├── build.sh
│       │   ├── Dockerfile
│       │   ├── lambda_function.py
│       │   └── requirements.txt
│       └── lambda_sqs_consumer
├── .gitignore
├── main.tf
├── providers.tf
└── terraform.tfvars