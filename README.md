Descrição Detalhada do Projeto "landetech_api"
O projeto "landetech_api" é uma API RESTful desenvolvida com Ruby on Rails, focada em fornecer funcionalidades de gerenciamento de recrutadores, vagas de emprego e submissões de candidatos. O projeto utiliza autenticação JWT, paginação e views em JSON, seguindo as melhores práticas de desenvolvimento de APIs modernas. Abaixo está uma descrição detalhada de cada componente e funcionalidade do projeto.

Tecnologias Utilizadas
Ruby 2.7.2: Linguagem de programação utilizada para desenvolver a aplicação.
Rails 6.0.0: Framework utilizado para construção da API.
PostgreSQL: Banco de dados relacional utilizado para armazenar os dados.
Devise: Gem utilizada para autenticação de usuários.
Devise-JWT: Gem utilizada para implementar autenticação via JSON Web Tokens.
Jbuilder: Gem utilizada para gerar views em JSON.
Kaminari: Gem utilizada para paginação.
Pundit: Gem utilizada para autorização.
Funcionalidades Implementadas
1. Gerenciamento de Recrutadores (Recruiters)
Model Recruiter:

Campos: name, email, password_digest
Associações: has_many :jobs
Validações: presence para name e email, has_secure_password para password
Controlador RecruitersController:

Ações: index, show, create, update, destroy
Filtros: before_action :authenticate_user!, exceto para index e show
Rotas:

GET /api/v1/recruiters: Listar todos os recrutadores
GET /api/v1/recruiters/:id: Mostrar um recrutador específico
POST /api/v1/recruiters: Criar um novo recrutador
PUT/PATCH /api/v1/recruiters/:id: Atualizar um recrutador
DELETE /api/v1/recruiters/:id: Deletar um recrutador
2. Gerenciamento de Vagas (Jobs)
Model Job:

Campos: title, description, start_date, end_date, status, skills, recruiter_id
Associações: belongs_to :recruiter, has_many :submissions
Validações: presence para title, description, recruiter_id
Controlador JobsController:

Ações: index, show, create, update, destroy
Filtros: before_action :authenticate_user!, exceto para index e show
Paginação: Utiliza kaminari para paginar os resultados em index
Rotas:

GET /api/v1/jobs: Listar todas as vagas ativas (paginado)
GET /api/v1/jobs/:id: Mostrar uma vaga específica
POST /api/v1/recruiters/:recruiter_id/jobs: Criar uma nova vaga para um recrutador específico
PUT/PATCH /api/v1/recruiters/:recruiter_id/jobs/:id: Atualizar uma vaga específica
DELETE /api/v1/recruiters/:recruiter_id/jobs/:id: Deletar uma vaga específica
3. Gerenciamento de Submissões (Submissions)
Model Submission:

Campos: name, email, mobile_phone, resume, job_id
Associações: belongs_to :job
Validações: presence para name, email, job_id, uniqueness para email dentro do escopo de job_id
Controlador SubmissionsController:

Ação: create
Rotas:

POST /api/v1/submissions: Criar uma nova submissão
4. Autenticação via JWT
Devise: Utilizado para gerenciamento de usuários e autenticação.
Devise-JWT: Configurado para gerar e validar tokens JWT.
Pundit: Utilizado para controle de acesso e autorização.
5. Views em JSON com Jbuilder
As respostas da API são renderizadas em JSON utilizando o Jbuilder para formatar os dados. As views incluem:

recruiters/index.json.jbuilder
recruiters/show.json.jbuilder
recruiters/_recruiter.json.jbuilder
jobs/index.json.jbuilder
jobs/show.json.jbuilder
jobs/_job.json.jbuilder
submissions/create.json.jbuilder
Estrutura de Pastas e Arquivos
Estrutura de Diretórios
app/controllers/api/v1: Contém os controladores para a API versão 1.
app/models: Contém os modelos de dados.
app/views/api/v1: Contém as views Jbuilder para a API.
config: Contém arquivos de configuração, incluindo rotas e inicializadores.
db: Contém migrações e schema do banco de dados.
test: Contém os testes unitários e de integração.
Arquivos de Configuração Importantes
config/routes.rb: Define as rotas da API.
config/initializers/devise.rb: Configurações do Devise, incluindo JWT.
config/database.yml: Configurações do banco de dados PostgreSQL.
Testes
Testes Unitários
Exemplo de teste unitário para o modelo Recruiter:

ruby
Copiar código
# test/models/recruiter_test.rb
require 'test_helper'

class RecruiterTest < ActiveSupport::TestCase
  test "should not save recruiter without name" do
    recruiter = Recruiter.new
    assert_not recruiter.save, "Saved the recruiter without a name"
  end
end
Testes de Request
Exemplo de teste de request para o controlador RecruitersController:

ruby
Copiar código
# test/controllers/api/v1/recruiters_controller_test.rb
require 'test_helper'

class Api::V1::RecruitersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recruiter = recruiters(:one)
  end

  test "should get index" do
    get api_v1_recruiters_url, as: :json
    assert_response :success
  end

  test "should create recruiter" do
    assert_difference('Recruiter.count') do
      post api_v1_recruiters_url, params: { recruiter: { name: 'John', email: 'john@example.com', password: 'password' } }, as: :json
    end
    assert_response 201
  end

  test "should show recruiter" do
    get api_v1_recruiter_url(@recruiter), as: :json
    assert_response :success
  end

  test "should update recruiter" do
    patch api_v1_recruiter_url(@recruiter), params: { recruiter: { name: 'John Updated' } }, as: :json
    assert_response 200
  end

  test "should destroy recruiter" do
    assert_difference('Recruiter.count', -1) do
      delete api_v1_recruiter_url(@recruiter), as: :json
    end
    assert_response 204
  end
end