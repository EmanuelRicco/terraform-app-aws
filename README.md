# Terraform AWS Docker App Deploy

Este repositório contém uma solução de **Infraestrutura como Código (IaC)** utilizando **Terraform** para provisionar uma aplicação Dockerizada em uma instância EC2 na **Amazon Web Services (AWS)**.

A arquitetura provisiona uma **VPC completa**, incluindo sub-redes públicas, Internet Gateway, tabelas de rotas e Security Groups configurados para permitir acesso à aplicação e administração via SSH.

---

## 🚀 Visão Geral da Arquitetura

A infraestrutura criada por este projeto é composta pelos seguintes recursos:

### 🌐 Virtual Private Cloud (VPC)

Rede virtual isolada na AWS utilizando o bloco CIDR:

```text
10.0.0.0/16
```

### 🔹 Sub-rede Pública

Sub-rede configurada dentro da VPC:

```text
10.0.1.0/24
```

Características:

* Atribuição automática de IP público para instâncias.
* Comunicação com a Internet através do Internet Gateway.

### 🌍 Internet Gateway (IGW)

Permite que os recursos da VPC se comuniquem com a Internet.

### 🛣️ Tabela de Rotas

Associada à sub-rede pública e configurada para encaminhar o tráfego externo:

```text
0.0.0.0/0 → Internet Gateway
```

### 🔒 Security Group

O Security Group da aplicação atua como firewall virtual da instância EC2.

#### Regras de Entrada (Ingress)

| Porta | Protocolo | Descrição  |
| ----- | --------- | ---------- |
| 22    | TCP       | Acesso SSH |
| 80    | TCP       | HTTP       |
| 443   | TCP       | HTTPS      |
| 8000  | TCP       | Aplicação  |

#### Regras de Saída (Egress)

Todo o tráfego de saída é permitido para possibilitar:

* Atualizações do sistema operacional;
* Download de dependências;
* Comunicação com serviços externos.

### 🖥️ Instância EC2

Instância Ubuntu utilizada para hospedar a aplicação Dockerizada.

**Tipo da instância:**

```text
t2.micro
```

### 🔑 Chave SSH

Par de chaves utilizado para acesso seguro à instância EC2.

### ⚙️ User Data

Durante a inicialização da instância, um script automatizado realiza:

* Instalação do Docker;
* Cópia dos arquivos da aplicação;
* Build da imagem Docker;
* Inicialização do container.

Mapeamento de portas:

```text
Container: 8000
Host EC2: 80
```

---

## 💻 Tecnologias Utilizadas

* Terraform
* AWS
* Docker
* Python
* Ubuntu Linux

---

## 📂 Estrutura do Projeto

```text
.
├── app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── terraform/
│   ├── compute.tf
│   ├── network.tf
│   ├── outputs.tf
│   ├── variables.tf
│   └── script/
│       └── docker_install.sh
│
└── README.md
```

### Descrição dos Arquivos

| Arquivo           | Descrição                            |
| ----------------- | ------------------------------------ |
| app.py            | Código-fonte da aplicação            |
| Dockerfile        | Build da imagem Docker               |
| requirements.txt  | Dependências Python                  |
| compute.tf        | Instância EC2 e chave SSH            |
| network.tf        | Recursos de rede                     |
| outputs.tf        | Saídas do Terraform                  |
| variables.tf      | Variáveis do projeto                 |
| docker_install.sh | Instala Docker e executa a aplicação |

---

## ⚙️ Pré-requisitos

Antes de iniciar, certifique-se de possuir:

### AWS CLI

Instalada e configurada com credenciais válidas:

```bash
aws configure
```

### Terraform

Versão mínima recomendada:

```text
Terraform >= 1.0
```

### Chave SSH

Um par de chaves SSH configurado em sua máquina local:

```text
~/.ssh/id_rsa
~/.ssh/id_rsa.pub
```

O Terraform utilizará a chave pública para criar o recurso `aws_key_pair`, enquanto a chave privada será usada para acessar a instância EC2.

---

## 🚀 Deploy da Infraestrutura

Inicialize o Terraform:

```bash
terraform init
```

Visualize o plano de execução:

```bash
terraform plan
```

Crie a infraestrutura:

```bash
terraform apply
```

Ao final do processo, o Terraform exibirá:

* IP público da instância;

---

## 🔍 Acessando a Aplicação

Após o provisionamento, acesse:

```text
http://<IP_PUBLICO>
```

---

## 🧹 Removendo a Infraestrutura

Para destruir todos os recursos criados:

```bash
terraform destroy
```

---

