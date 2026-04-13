# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Limpando e populando domínios..."

domains = {
  SexType => ['Masculino', 'Feminino', 'Não Informado'],
  RaceType => ['Branca', 'Preta', 'Parda', 'Amarela', 'Indígena', 'Não Informado'],
  ProcessType => ['Criminal', 'Cível', 'Infracional', 'Outros'],
  BloodType => ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-', 'Não Informado'],
  ChildContactRole => ['Pai', 'Mãe', 'Irmão(ã)', 'Avô(ó)', 'Tio(a)', 'Outro'],
  FamilySide => ['Materno', 'Paterno', 'Ambos', 'Não Informado'],
  IndividualCareType => ['Médico', 'Psicológico', 'Odontológico', 'Fisioterápico', 'Outros'],
  SchoolEventType => ['Matrícula', 'Reunião de Pais', 'Ocorrência Disciplinar', 'Transferência', 'Outros'],
  HealthEventType => ['Consulta', 'Exame', 'Vacina', 'Internação', 'Cirurgia', 'Outros'],
  FileType => ['Documento Pessoal', 'Processo Judicial', 'Relatório Técnico', 'Foto', 'Outros']
}

domains.each do |model, values|
  values.each do |val|
    model.find_or_create_by!(description: val)
  end
  puts "  - #{model.name} pronto."
end

puts "Tabelas de domínio migradas com sucesso!"

puts "Criando usuário admin"

admin_role = Role.find_or_create_by!(description: 'ROLE_ADMIN')
user_role  = Role.find_or_create_by!(description: 'ROLE_USER')

admin = UserAccount.find_or_create_by!(email: 'admin@openarms.com') do |u|
  u.full_name = 'Administrador Sistema'
  u.password = 'admin123' # O has_secure_password vai transformar isso em hash
  u.enabled = true
end

admin.roles << admin_role unless admin.roles.include?(admin_role)

puts "Usuário Admin criado com sucesso!"