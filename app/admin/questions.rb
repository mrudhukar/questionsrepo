ActiveAdmin.register Question do

  scope :all, :default => true
  Subject.all.each do |subject|
    self.send(:scope, subject.name) do |questions|
      questions.joins(:objective => :topic).where(:topics => {:subject_id => subject.id})
    end
  end

  filter :objective
  filter :title
  filter :difficulty, :as => :check_boxes, :collection => Question::Difficulty::S_TO_V
  filter :description
  filter :hint


  index do
    selectable_column
    column "Title", :sortable => "title" do |qs|
      link_to qs.title, admin_question_path(qs)
    end

    column "Difficulty", :sortable => "difficulty" do |qs|
      Question::Difficulty::V_TO_S[qs.difficulty]
    end

    column "Description", :sortable => false do |qs|
      qs.description.truncate(100)
    end

    column "Hint", :sortable => false do |qs|
      qs.hint.truncate(100)
    end
    
    column "Subject" do |qs|
      link_to(qs.subject.name, admin_subject_path(qs.subject))
    end

    column "Topic" do |qs|
      link_to(qs.topic.name, admin_topic_path(qs.topic))
    end
    column :objective

    column "Number of Choices" do |qs|
      qs.choices.size
    end

    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :objective
      f.input :title
      f.input :description, :input_html => {:rows => 3}
      f.input :difficulty, :as => :select, :collection => Question::Difficulty::S_TO_V
      f.input :hint, :input_html => {:rows => 3}
    end

    f.has_many :choices do |app_f|
      unless app_f.object.new_record?
        # show the destroy checkbox only if it is an existing appointment
        # else, there's already dynamic JS to add / remove new appointments
        app_f.input :_destroy, :as => :boolean, :label => "Remove this choice?"
      end
      app_f.input :value , :input_html => {:rows => 1}
      app_f.input :reason, :input_html => {:rows => 3}
      app_f.input :correct
      app_f.input :order
    end

    f.actions
  end

  show do
    attributes_table do
      row "Subject" do
        link_to(question.subject.name, admin_subject_path(question.subject))
      end
      row "Topic" do
        link_to(question.topic.name, admin_topic_path(question.topic))
      end
      row :objective
      row :title
      row :difficulty do
        Question::Difficulty::V_TO_S[question.difficulty]
      end
      row :description
      row :hint
    end

    panel "Choices (#{question.choices.size})" do
      table_for question.choices do
        column :value
        column :reason
        column :correct
        column :order
      end
    end

    active_admin_comments
  end
  
end
