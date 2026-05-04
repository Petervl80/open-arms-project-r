# Open Arms Project — API 🤝

> API backend em **Ruby on Rails** para gestão do acolhimento institucional de crianças e adolescentes — controlando dados pessoais, saúde, educação, assistência, processos legais e reintegração familiar.

---

## 🚀 Tecnologias Utilizadas

| Categoria | Tecnologia |
|---|---|
| **Linguagem** | Ruby 3.4.9 |
| **Framework** | Ruby on Rails 8.1.3 (API Only) |
| **Banco de Dados** | MySQL 9.1 |
| **Autenticação** | JWT + `bcrypt` |
| **Exportação / Relatórios** | Axlsx / CAxlsx (Excel) · Wicked_PDF (PDF) |
| **Serialização JSON** | Blueprinter |
| **Background Jobs & Cache** | Solid Queue · Solid Cache · Solid Cable |
| **Infraestrutura** | Docker · Docker Compose · Kamal (Deploy) |

---

## 📋 Pré-requisitos

- **Ruby** 3.4.9
- **Docker** e **Docker Compose** — para o banco de dados em container local
- **Bundler**

---

## ⚙️ Configuração do Ambiente de Desenvolvimento

### 1. Clone o repositório

```bash
git clone <url-do-repositorio>
cd open_arms
```

### 2. Inicie o banco de dados com Docker Compose

> O MySQL está configurado para rodar na porta **3308** (conforme `docker-compose.yml` e `database.yml`).

```bash
docker-compose up -d
```

### 3. Instale as dependências

```bash
bundle install
```

### 4. Prepare o banco de dados

Este comando cria o banco, roda as migrations e popula as tabelas de domínio via seeds.

```bash
rails db:prepare
rails db:seed
```

### 5. Inicie o servidor local

```bash
bin/dev
# ou
rails server
```

---

## 🔐 Autenticação

A API utiliza **tokens JWT** para autorização. Todos os endpoints privados exigem o header:

```
Authorization: Bearer <seu_token>
```

### Obtendo um token

Faça um `POST` na rota de login:

```
POST /api/v1/auth/login
```

```json
{
  "email": "admin@openarms.com",
  "password": "admin123"
}
```

### Usuários padrão (Seeds)

O arquivo `db/seeds.rb` cria automaticamente os seguintes perfis para testes:

| Perfil | E-mail | Senha |
|---|---|---|
| Administrador | `admin@openarms.com` | `admin123` |
| Equipe Técnica | `tech@openarms.com` | `tech123` |
| Pedagogo(a) | `pedagogue@openarms.com` | `pedagogue123` |
| Educador(a) | `educator@openarms.com` | `educator123` |

---

## 🗂️ Estrutura e Principais Funcionalidades

A API foi projetada de forma modular, tendo a entidade **Criança** (`Child`) como eixo central de todas as ramificações informacionais.

### 👶 Gestão da Criança
`GET|POST|PATCH /api/v1/children`

Dados vitais, número de processo judicial, dados de certidão e processos de admissão/alta.

---

### 🏥 Saúde & Cuidados Individuais
`HealthEvent · IndividualCare`

Histórico de avaliações médicas, vacinas, doenças (HIV, Hepatite, Sífilis) e cuidados psicológicos, odontológicos e terapêuticos.

---

### 📚 Educação
`SchoolProgress`

Ocorrências pedagógicas e evolução de aprendizado.

---

### 🤝 Convívio e Eventos Sociais
`SocialActivity · SocialDevelopmentEntry`

Registros do dia a dia, respeito às regras e participação em atividades sociais.

---

### 🎯 Plano de Ação
`ActionPlanItem`

Controle das metas de atendimento e perspectivas de reintegração da criança.

---

### 👨‍👩‍👧 Contatos e Família
`Contact · FamilyEvent`

Mapeamento dos lados materno e paterno, controle de contato familiar e eventos registrados pela equipe.

---

### 📎 Arquivos e Anexos
`FileAsset`

Upload em storage local, com validação e referência no banco de dados.

---

### 📊 Exportação (PIA)

Geração sob demanda do **Plano Individual de Atendimento (PIA)** nos formatos `.xlsx` e `.pdf`:

```
GET /api/v1/exports/children/:id/xlsx
GET /api/v1/exports/children/:id/pdf
```