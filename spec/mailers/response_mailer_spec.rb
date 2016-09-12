describe ResponseMailer do
  describe '#reponse_email' do
    subject { described_class.response_email(params) }

    context 'valid params' do
      let(:params) do
        {
          requester_email: 'some@doctor.dev',
          response_uuid: SecureRandom.uuid
        }
      end

      it 'is sent to the to address' do
        expect(subject.to).to eq [params[:requester_email]]
      end

      it 'contains a link to show the filled in questionnaires', skip: true do
        # expect(subject.body.encoded).to include("http://test_host/fillOut?invitationUUID=#{params[:invitation_uuid]}")
      end
    end
  end
end
