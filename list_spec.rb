require "rspec"

require_relative "list"

describe List do
  let (:incomplete_task) {mock(:task, :complete? => false)}
  let (:completed_task) {mock(:task, :complete? => true)}
  let (:titled_list) {List.new("title")}
  let (:untitled_list) {List.new}

  describe '#initialize' do
    it 'takes one required parameter for title' do
      expect {untitled_list}.to raise_error(ArgumentError)
    end

    it 'returns an instance of List' do
      expect(titled_list).to be_a_kind_of(List)
    end
  end

  describe '#add_task' do
    it 'adds new task to task array' do
      titled_list.add_task(completed_task)
      expect(titled_list.tasks).to include (completed_task)
    end
  end

  describe '#complete_task' do
    it 'returns false if there are no tasks at input index' do
      titled_list.tasks << incomplete_task
      expect(titled_list.complete_task(1)).to eq(false)
    end

    it 'calls complete! on a task at a specific index number' do
      incomplete_task.should_receive(:complete!)
      titled_list.tasks << incomplete_task
      titled_list.complete_task(0)
    end
  end

  describe '#delete_task' do
    it 'returns false if there are no tasks at input index' do
      titled_list.tasks << completed_task
      expect(titled_list.delete_task(1)).to eq(false)
    end

    it 'calls delete_at on a task at a specific index number' do
      titled_list.tasks << completed_task
      titled_list.delete_task(0)
      expect(titled_list.tasks.length).to eq(0)
    end
  end

  describe '#completed_tasks' do
    it "shows all completed tasks" do
      expect(titled_list.completed_tasks).to eq []
    end

    it 'calls complete? on every item in the tasks array' do
      list2  = List.new("Title", [completed_task, completed_task, completed_task, incomplete_task, incomplete_task])
      expect(list2.completed_tasks.length).to eq 3
    end
  end

  describe '#incomplete_tasks' do
    it "shows all incomplete tasks" do
      list2  = List.new("Title", [completed_task, completed_task, completed_task, incomplete_task, incomplete_task])
      expect(list2.incomplete_tasks.length).to eq 2
    end
  end
end
