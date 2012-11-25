ActiveAdmin.register Objective do

  scope :all, :default => true
  # Subject.all.each do |subject|
  #   self.send(:scope, subject.name) do |objectives|
  #     objectives.joins(:topic).where(:topics => {:subject_id => subject.id})
  #   end
  # end

  filter :topic
  filter :name
  filter :grade

  index do
    selectable_column
    column "Objective Name", :sortable => "name" do |obj|
      link_to obj.name, admin_objective_path(obj)
    end
    column :grade
    column "Subject" do |obj|
      link_to(obj.subject.name, admin_subject_path(obj.subject))
   end
    column :topic
    column "Number of Questions" do |obj|
      obj.questions.size
    end

    default_actions
  end

  show do
    attributes_table do
      row "Subject" do
        link_to(objective.subject.name, admin_subject_path(objective.subject))
      end
      row :topic
      row :name
      row :grade
    end

    panel "Questions (#{objective.questions.size})" do
      table_for objective.questions do
        column "Title" do |qs|
          link_to qs.title, admin_question_path(qs)
        end
        column "Difficulty" do |qs|
          Question::Difficulty::V_TO_S[qs.difficulty]
        end
        column "Description" do |qs|
          qs.description.truncate(200)
        end
        column "Number of Choices" do |qs|
          qs.choices.size
        end
      end
    end

    active_admin_comments
  end
end
