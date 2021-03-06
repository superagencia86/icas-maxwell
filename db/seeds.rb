# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
%w(Cliente Cliente\ agencia Proveedor Contacto Formación Otro\ tipo\ de\ relación).each do |name|
  Relationship.find_or_create_by_name(:name => name)
end

%w(Empresa\ pública Semiprivada PYME\ privada Gran\ empresa Otro\ tipo).each do |name|
  CompanyType.find_or_create_by_name(:name => name)
end

["Instituciones públicas", "Fundaciones y obras sociales", "Empresa cultural", "Asociaciones culturales", "Museos-salas expositivas", "Salas escénicas", "Centros educativos", "Centros Cívicos", "Bibliotecas", "ICAS - Servicios centrales", "ICAS - Teatro Lope de Vega", "ICAS - CaS", "ICAS - Teatro Alameda", "ICAS - Red Municipal de Bibliotecas", "ICAS - Archivo, Hemeroteca y Publicaciones"].each do |name|
  InstitutionType.find_or_create_by_name(name)
end

%w(Agroalimentario Asesoría\ legal Banca\ y\ finanzas Construcción\ y\ autopistas Consultoría\ y\ abogados Cultura Deportes Diseño,\ ilustración\ y\ fotografía Distribución Energía Farmacia Formación Hostelería,\ restauración\ y\ catering Imprentas Informática Industria Ingeniería\ y\ arquitectura Inmobiliaria\ y\ construcción Medio\ ambiente Medios\ de\ comunicación Mensajería\ y\ transporte Motor Mobiliario\ y\ material\ de\ oficina Productoras\ audiovisuales Publicidad\ y\ marketing Salud\ y\ belleza Seguros Servicios Software\ y\ desarrollo Tecnología Telecomunicaciones Textil,\ moda\ y\ confección Traducción Transportes Turismo Ocio\ y\ tiempo\ libre Otros).each do |name|
  Sector.find_or_create_by_name(:name => name)
end
["Consejo cultura y empresa", "Consejo de publicaciones", "Foro de agentes culturales", "Danza", "Música", "Teatro", "Cine", "Artes plásticas", "Libros - poesía", "Archivo, Hemeroteca y Publicaciones", "Casino de la exposición", "Centro de las Artes de Sevilla", "Red Municipal de Bibliotecas", "Teatro Alameda", "Teatro Lope de Vega"].each do |name|
  Hobby.find_or_create_by_name(:name => name)
end
