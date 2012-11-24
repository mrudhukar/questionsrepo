ActiveAdmin.register Subject do
  filter :name

  index do
    selectable_column
    column "Subject Name", :sortable => "name" do |subject|
      link_to subject.name, admin_subject_path(subject)
    end
    column "Number of Topics" do |subject|
      subject.topics.size
    end
    column "Number of Objectives" do |subject|
      subject.objectives.size
    end
    column "Number of Questions" do |subject|
      subject.questions.size
    end
    default_actions
  end

  show do
    panel "Topics (#{subject.topics.size})" do
      table_for subject.topics do
        column "Name" do |topic|
          link_to topic.name, admin_topic_path(topic)
        end
        column "Number of Objectives" do |topic|
          topic.objectives.size
        end
        column "Number of Questions" do |topic|
          topic.questions.size
        end
      end
    end

    panel "Objectives (#{subject.objectives.size})" do
      table_for subject.objectives do
        column :topic
        column "Name" do |obj|
          link_to obj.name, admin_objective_path(obj)
        end
        column :grade
        column "Number of Questions" do |obj|
          obj.questions.size
        end
      end
    end

    panel "Questions (#{subject.questions.size})" do
      table_for subject.questions do
        column "Topic" do |qs|
          link_to(qs.topic.name, admin_topic_path(qs.topic))
        end
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
