describe 'instructeurs/dossiers/instruction_button_motivation.html.haml', type: :view do
  let(:dossier) { create(:dossier, :en_instruction) }

  subject do
    render(
      'instructeurs/dossiers/instruction_button_motivation.html.haml',
      dossier: dossier,
      popup_title: 'Accepter le dossier',
      placeholder: 'Expliquez au demandeur pourquoi ce dossier est accepté (facultatif)',
      popup_class: 'accept',
      process_action: 'accepter',
      title: 'Accepter',
      confirm: "Confirmez-vous l'acceptation ce dossier ?"
    )
  end

  context 'without attestation' do
    it { expect(subject).not_to have_link(href: apercu_attestation_instructeur_dossier_path(dossier.procedure, dossier)) }
  end

  context 'with an attestation' do
    let(:dossier) { create :dossier, :accepte, :with_attestation }

    it 'includes a link to preview the attestation' do
      expect(subject).to have_link(href: apercu_attestation_instructeur_dossier_path(dossier.procedure, dossier))
    end
  end
end
