# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeeCreate do
  describe '#call' do
    subject { described_class.new(params: params) }

    let(:params) do
      { name: 'John Doe', email: email, title: 'Title', work_focus: 'development' }
    end
    let(:default_password) { 'password' }

    context 'when employee creation is successful' do
      let(:email) { 'john@example.com' }

      it 'creates Employee' do
        expect { subject.call }.to change { Employee.all.reload.count }.by(1)
      end
    end

    context 'when employee creation fails' do
      let(:email) { 'johnexample.com' }

      it 'adds validation error' do
        subject.call
        expect(subject.errors).to include('Email is invalid')
      end
    end
  end
end
