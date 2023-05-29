project_manager = FactoryBot.create(:project_manager, email: 'test@email.co')
FactoryBot.create_list(:task, 3, project_manager: project_manager)
