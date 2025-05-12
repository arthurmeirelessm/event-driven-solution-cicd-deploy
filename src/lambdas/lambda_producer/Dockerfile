# Use a imagem base do AWS Lambda com Python 3.11
FROM public.ecr.aws/lambda/python:3.11

# Copie o requirements.txt para o diretório de trabalho no Lambda
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Instale as dependências do requirements.txt
RUN pip install -r requirements.txt

# O comando que o Lambda vai rodar
CMD [ "lambda_function.lambda_handler" ]
