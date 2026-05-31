
Terraform AWS Docker App Deploy

Este repositório contém uma solução de Infraestrutura como Código (IaC) utilizando Terraform para provisionar uma aplicação Dockerizada em uma instância EC2 na Amazon Web Services (AWS). A arquitetura inclui uma Virtual Private Cloud (VPC) completa, com sub-redes públicas, Internet Gateway e Security Groups configurados para acesso à aplicação e SSH.

🚀 Visão Geral da Arquitetura

A infraestrutura provisionada por este projeto consiste em:

•
Virtual Private Cloud (VPC): Uma rede virtual isolada na AWS com um bloco CIDR 10.0.0.0/16.

•
Sub-rede Pública: Uma sub-rede (10.0.1.0/24) dentro da VPC, configurada para atribuir IPs públicos automaticamente às instâncias lançadas nela.

•
Internet Gateway (IGW): Permite a comunicação entre a VPC e a internet.

•
Tabela de Rotas: Associada à sub-rede pública, direciona o tráfego externo (0.0.0.0/0) para o Internet Gateway.

•
Security Group (sg_app): Atua como um firewall virtual para a instância EC2, permitindo tráfego de entrada nas portas:

•
22 (SSH) - para acesso administrativo.

•
80 (HTTP) - para acesso à aplicação web.

•
443 (HTTPS) - para acesso seguro à aplicação web.

•
8000 (Custom App Port) - para a porta interna da aplicação.

•
Tráfego de saída (egress) totalmente liberado para permitir que a instância baixe atualizações e se comunique com serviços externos.

•
Instância EC2: Uma máquina virtual Ubuntu (t2.micro) onde a aplicação Dockerizada será executada.

•
Chave SSH: Um par de chaves SSH para acesso seguro à instância EC2.

•
User Data Script: Um script bash executado na inicialização da instância EC2 para:

•
Instalar o Docker.

•
Copiar os arquivos da aplicação (app.py, Dockerfile, requirements.txt).

•
Construir a imagem Docker da aplicação.

•
Executar o container Docker, mapeando a porta 8000 do container para a porta 80 da instância.



💻 Tecnologias Utilizadas

•
Terraform: Para provisionamento e gerenciamento da infraestrutura como código.

•
AWS: Provedor de nuvem para hospedar a infraestrutura.

•
Docker: Para conteinerização da aplicação.

•
Python: Linguagem da aplicação usada para API.

•
Ubuntu: Sistema operacional da instância EC2.

📂 Estrutura do Projeto

.
├── app/
│   ├── app.py              # Codigo da aplicacao Python
│   ├── Dockerfile          # Dockerfile para construir a imagem da aplicacao
│   └── requirements.txt    # Dependencias Python da aplicacao
├── terraform/
│   ├── compute.tf          # Configuracao da instancia EC2 e chave SSH
│   ├── network.tf          # Configuracao da VPC, sub-rede, IGW e tabelas de rotas
│   ├── outputs.tf          # Saidas uteis apos o deploy (IP, DNS, comando SSH)
│   ├── variables.tf        # Variaveis de configuracao do Terraform
│   └── script/
│       └── docker_install.sh # Script para instalar Docker e rodar a aplicacao
└── README.md


⚙️ Pré-requisitos

Antes de iniciar, certifique-se de ter os seguintes itens instalados e configurados:

•
AWS CLI: Configurado com credenciais de acesso à sua conta AWS.

•
Terraform: Versão 1.0 ou superior.

•
Chave SSH: Um par de chaves SSH configurado em ~/.ssh/ na sua máquina local. O Terraform usará a chave pública para criar o aws_key_pair e você usará a chave privada para acessar a instância.


⚠️ Considerações de Segurança

Este projeto foi configurado com regras de Security Group que permitem acesso de 0.0.0.0/0 (qualquer IP) para SSH, HTTP, HTTPS e a porta 8000. Esta configuração é adequada para ambientes de teste e desenvolvimento.

Para ambientes de produção, é altamente recomendável restringir o acesso a IPs específicos ou a outros Security Groups para SSH e portas de aplicação, seguindo o princípio do menor privilégio. Por exemplo, para SSH, você deve permitir acesso apenas do IP da sua máquina ou da rede da sua VPN.




