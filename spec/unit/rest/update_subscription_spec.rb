require "spec_helper"

describe Cashbox::Rest::UpdateSubscription do
  class self::TestModel < Cashbox::Model
    include Cashbox::Rest::UpdateSubscription
    property :vid
  end

  describe "#update" do
    subject { self.class::TestModel.new({ vid: "my-vid" }) }
    let(:request) { double("request", { response: "my data" }) }
    let(:new_product_id) { "123" }
    let(:old_product_id) { "456" }

    context "update with adding a new product id to the subscription" do
      before do
        allow(subject.class).to receive(:cast)

        allow(Cashbox::Request).to receive(:new)
          .with(:post, "/test_models/my-vid?effective_date=today&bill_prorated_period=true", {
          body: {
            items: [
              object: "Subscription",
              id: "my-vid",
              product: {
                object: "Product",
                id: new_product_id
              }
            ]
          }.to_json
        })
        .and_return(request)

        subject.update_subscription(new_product_id)
      end

      it "calls the Cashbox::Request correctly when sent in parameters contains only a new product id" do
        expect(Cashbox::Request).to have_received(:new)
          .with(:post, "/test_models/my-vid?effective_date=today&bill_prorated_period=true", {
          body: {
            items: [
              object: "Subscription",
              id: "my-vid",
              product: {
                object: "Product",
                id: new_product_id
              }
            ]
          }.to_json
        })
      end
    end

    context "update with value to replace product" do
      before do
        allow(subject.class).to receive(:cast)

        allow(Cashbox::Request).to receive(:new)
          .with(:post, "/test_models/my-vid?effective_date=today&bill_prorated_period=true", {
          body: {
            items: [
              object: "Subscription",
              id: "my-vid",
              product: {
                object: "Product",
                id: new_product_id
              },
              replaces: {
                object: "SubscriptionItem",
                product:  {
                  object: "Product",
                  id: old_product_id
                }
              }
            ]
          }.to_json
        })
        .and_return(request)

        subject.update_subscription(new_product_id, old_product_id)
      end

      it "calls the Cashbox:Request correctly when the replace product id paramenter is sent in" do
        expect(Cashbox::Request).to have_received(:new)
        .with(:post, "/test_models/my-vid?effective_date=today&bill_prorated_period=true", {
          body: {
            items: [
              object: "Subscription",
              id: "my-vid",
              product: {
                object: "Product",
                id: new_product_id
              },
              replaces: {
                object: "SubscriptionItem",
                product:  {
                  object: "Product",
                  id: old_product_id
                }
              }
            ]
          }.to_json
        })
      end
    end
  end
end
