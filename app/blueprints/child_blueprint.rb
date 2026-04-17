class ChildBlueprint < Blueprinter::Base
  identifier :id
  
  fields :full_name, :process_number, :birth_date, :cpf, :rg, :nationality
  
  association :sex_type, blueprint: SexTypeBlueprint
  
  # Uma view mais simples para a listagem (Index) e uma detalhada para o perfil (Show).
  view :extended do
    association :race_type, blueprint: RaceTypeBlueprint # Assumindo que criará este blueprint depois
    association :process_type, blueprint: ProcessTypeBlueprint
    # fields :disability_notes, :registry_office
  end
end