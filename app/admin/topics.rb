ActiveAdmin.register Topic do

  scope :all, :default => true
  Subject.all.each do |subject|
    self.send(:scope, subject.name) do |topics|
      topics.where(:subject_id => subject.id)
    end
  end

  filter :name

  index do
    selectable_column
    column "Topic Name", :sortable => "name" do |topic|
      link_to topic.name, admin_topic_path(topic)
    end
    column :subject
    column "Number of Objectives" do |topic|
      topic.objectives.size
    end
    column "Number of Questions" do |topic|
      topic.questions.size
    end

    default_actions
  end

  show do
    attributes_table do
      row :subject
      row :name
    end

    panel "Objectives (#{topic.objectives.size})" do
      table_for topic.objectives do
        column "Name" do |obj|
          link_to obj.name, admin_objective_path(obj)
        end
        column :grade
        column "Number of Questions" do |obj|
          obj.questions.size
        end
      end
    end

    panel "Questions (#{topic.questions.size})" do
      table_for topic.questions do
        column :objective
        column "Title" do |qs|
          link_to qs.title, admin_question_path(qs)
        end
        column "Difficulty" do |qs|
          Question::Difficulty::V_TO_S[qs.difficulty]
        end
        column "Description" do |qs|
          qs.description.truncate(100)
        end
        column "Number of Choices" do |qs|
          qs.choices.size
        end
      end
    end

    active_admin_comments
  end
  
end
