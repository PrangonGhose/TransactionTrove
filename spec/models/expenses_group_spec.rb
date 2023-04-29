require 'rails_helper'

RSpec.describe ExpensesGroup, type: :model do
  let!(:user) { User.create(name: 'Prangon Ghose', email: 'test@example.com', password: '12345678') }
  let!(:group) { Group.create(name: 'Group 1', icon: 'www.test.com', user: user) }
  let!(:expense) { Expense.create(name: 'Expense 1', amount: 100, user: user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      group_expense = ExpensesGroup.new(group: group, expense: expense)
      expect(group_expense).to be_valid
    end

    it 'is not valid without a group' do
      group_expense = ExpensesGroup.new(expense: expense)
      expect(group_expense).not_to be_valid
    end

    it 'is not valid without an expense' do
      group_expense = ExpensesGroup.new(group: group)
      expect(group_expense).not_to be_valid
    end

    it 'is not valid with a duplicate group and expense combination' do
      ExpensesGroup.create(group: group, expense: expense)
      group_expense = ExpensesGroup.new(group: group, expense: expense)
      expect(group_expense).not_to be_valid
    end
  end
end
