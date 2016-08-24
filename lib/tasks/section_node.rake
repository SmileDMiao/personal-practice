namespace :section_node do

	desc 'sections and nodes'
	task :create_section_node => :environment do
		s1 = Section.create(name: 'Ruby',sort: 0)
		Node.create(name: 'Ruby', summary: '...', section_id: s1.id)
	end

end
