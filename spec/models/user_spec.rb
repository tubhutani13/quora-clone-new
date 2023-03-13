require "rails_helper"

RSpec.describe User, type: :model do
  context "User class" do
    context "Constants" do
      it { expect(VALID_EMAIL_REGEX).to eq(/\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i) }
    end

    describe "Module Inclusions" do
      it {
        expect(User.ancestors).to include(TokenHandler)
      }
    end

    context "Inheritance" do
      it { expect(User.superclass).to eq ApplicationRecord }
    end
  end

  context "enum" do
    let(:normal_user) { create(:user) }
    let(:admin_user) {create(:user, :admin)}
    it "has a default role of user" do
      expect(normal_user.user?).to be_truthy
    end

    it "admin has a admin role" do
      expect(admin_user.admin?).to be_truthy
    end
  end

  context "Validations" do
  end
end
