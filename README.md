Ambiente docker completo para data science a analytics

# 📦 O que esse ambiente tem:
✅ Acesso a variáveis de ambiente;<br/>
✅ anaconda;<br/>
✅ spyder;<br/>
✅ jupyter;<br/>
✅ mysql;<br/>
✅ postgres;<br/>
✅ mongodb;<br/>
✅ mongo-express;<br/>

# 🐋 Por que usar um ambiente em container?
✅ O ambiente é o mesmo independente da máquina em que é hospedado;<br/>
✅ O ambiente é construído com apenas um comando;<br/>
✅ Você pode ter vários bancos de dados de teste;<br/>
✅ Não interfere na configuração da sua máquina;<br/>

# 📦 Vá de acordo com sua necessidade
Esse ambiente tem muitas coisas que você pode precisar, mas provavelmente você não vai precisar de tudo isso ao mesmo tempo;<br>
Se você não precisa de bancos de dados, você comentar ou excluir as linhas desse serviço no `compose.yaml`, afinal, se você não vai usar mysql, postgres ou mongodd, não há a necessidade de consumir recursos para isso.<br/>
Você também pode comentar os pacotes que você não vai utilizar no arquivo `requeriments.txt`, ou no `DockerFile`, como o tensorflow ou pyspark (linha 79 e 81);<br/>

Você pode decidir deixar o ambiente com a configuração completa, isso pode ser útil para muitos tipos de testes e análises, porém fique ciente que a imagem pode demorar alguns minutos para ser construída na primeira vez em que for executada, pois atualmente o ambiente completo tem 20 GB.<br/>

# 🛠️ INSTALAÇÃO

**⚠️ ATENÇÃO!**<br/>
Antes de proceder, verifique se o `docker` e o `docker-compose` estão instaldos na sua máquina, utilizando os comandos abaixo:
```bash
docker --version
docker-compose --version
```

**⚠️ ATENÇÃO!**<br/>
Antes e executar 

### Passos para executar o projeto:

### 1. Clonar o projeto:
```bash
 git clone git@github.com:lmuffato/docker-data-science-anaconda.git
```

# 2. Linux

### Montar o container da aplicação:
#### 2.1. Montar o projeto através do script automatizado `start.sh`:<br>

**⚠️ ATENÇÃO!**<br/>
O script automatizado funciona apenas em ambiente `linux`. <br>

#### 2.2. Abra o terminal na raiz do projeto e execute o comando:
```bash
chmod +x start.sh
```
Observação: Só é necessário conceder permissão uma única vez.<br>

#### 2.3. Executar o script:
```bash
./start.sh
```

✅ Após a execução do script, a aplicação estará pronta e em funcionamento através do container.

# 3. Windows

#### 3.1. Montar o projeto `manualmente` com os comandos docker:

#### 3.2. Criar o arquivo `.env` a partir do `.env.example`:
```bash
cp .env.example .env
```

#### 3.3. Montar o container:
Dentro da pasta backend, digite o comando abaixo:
```bash
docker-compose -p datascience up -d --build
```

#### Em caso de erro ao montar o container, faça a montagem sem a utilização de cache, ignorando imagens as existentes:
```bash
docker-compose -p datascience up -d --build --no-cache
```
**⚠️ OBSERVAÇÃO:**<br/>
O nome do container deve ser o mesmo definido no `.env`.


✅ Após a execução dos comandos, a aplicação estará pronta e em funcionamento através do container.

# 4. Uso da GPU no container:

Caso a máquina Host não tenha GPU, abra o arquivo `compose.yaml` na raiz do projeto e comente as linhas: <br>
21, 22, 36, 37, 38, 39 e 40
<br>

Caso a máquina Host tenha GPU Nvidia compatível, para que o container tenha acesso a todos os recursos da GPU, é necessário instalar o `NVIDIA Container Toolkit` na máquina `host`.

Você pode encontrar informações de como instalar o Toolkit no site oficial da nvidia:
```
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
```

Se a GPU for reconhecida com suceso, ao executar o comando abaixo dentro do container, irá retornar informações da placa:
```
nvidia-smi
```

# 5. Spyder:
Basta executar o comando abaixo no terminal:
```
./spyder-run.sh
```

Ou entrar dentro do terminal do container e executar:
```
spyder
```

**⚠️ OBSERVAÇÃO:**<br/>
1. Por padrão, o Spyder usa o diretório de trabalho `home/user`.
Vá em configurações do spyder e mude o diretório para a raiz do projeto, isso vai evitar de ter que declarar o workdir para importar os arquivos e além disso, esse diretório não persiste informações após deletar o container, por isso deve-se usar o diretório padrão da raíz do projeto.

2. As versões mais rescentes do spyder, quase sempre travam ao encerrar ou reiniciar o spyder, sendo necessário encerrar no host ou pausar o container. Um pequeno incoveniente a ser corrigido.

# 6. Jupyter
Para executar o jupyter, basta executar o script abaixo:
```
./jupyter-run.sh
```

O jupyter será disponível no navegador acessível pelo link:
```
http://localhost:8889/tree?
```

Para cancelar o servidor, basta apertar `Ctrl C` no terminal que está executando.

**⚠️ OBSERVAÇÃO:**<br/>
Se o valor de `JUPYTER_REQUIRES_AUTHENTICATION` for `True` no .env, o script irá salvar o link com token de acesso para o jupyter, e é só copia e colar no navegador.

# 7. mongo-express

O mongo-express é uma interface para acessar o banco de dados do mongodb, muito útil pois não depende de instalação na máquina.
Acessível por:
```
http://localhost:8081/
```

# 8. Bancos de dados: `mongodb`, `mysql` e `postgres`:
Caso não vá utilizar esses bancos de dados, pode-se comentar os blocos das imagens no `compose.yaml`, poupando memória.

# INFORMAÇÕES:
A pasta `data_files` tem o propósito de armazenar arquivos de dados, como `csv`, `parquet`, `xlsx` e etc... Nada dentro dessa pasta será enviado ao github.

Intercâmbio de IDES:
É possível criar um arquivo no spyder ou jupyter e editar e salvar no VsCode ou outra IDE. O fluxo contrário também é possível.
