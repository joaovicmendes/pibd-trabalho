package br.ufscar.dc.pibd.postgres;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class App {
    JFrame mainFrame;
    JFrame secondaryFrame;
    GridLayout gridLayout;

    JPanel panel1;
    ButtonGroup buttonGroup;
    JCheckBox isPessoa;
    JLabel pessoaLabel;
    JCheckBox isCarro;
    JLabel carroLabel;

    JPanel panel2;
    JLabel labelTextField;
    JTextField textField;
    JTextArea textArea;
    JButton querySend;

    JPanel panelButtons;
    JButton addCarro;

    // Add Carro
    JPanel carroPanel;
    JLabel carroPlaca;
    JTextField carroPlacaText;
    JLabel carroAno;
    JTextField carroAnoText;
    JLabel carroModelo;
    JTextField carroModeloText;
    JLabel carroCor;
    JTextField carroCorText;
    JButton addCarroConfirm;
    JTextArea addCarroTextArea;
    JButton addCancelCarro;

    // Add Pessoa
    JLabel pessoaCodigo;
    JTextField pessoaCodigoText;
    JButton addPessoa;
    JButton addPessoaConfirm;
    JPanel pessoaPanel;
    JTextArea addPessoaTextArea;
    JLabel pessoaNome;
    JTextField pessoaNomeText;
    JLabel pessoaDataNasc;
    JTextField pessoaDataNascText;
    JLabel pessoaHomepage;
    JTextField pessoaHomepageText;
    JLabel pessoaCep;
    JTextField pessoaCepText;
    JLabel pessoaRua;
    JTextField pessoaRuaText;
    JLabel pessoaNumero;
    JTextField pessoaNumeroText;
    JLabel pessoaComplemento;
    JTextField pessoaComplementoText;
    JButton addCancelPessoa;

    // Add Possui
    JPanel possuiPanel;
    JButton addPossui;
    JButton addPossuiConfirm;
    JTextArea addPossuiTextArea;
    JButton addCancelPossui;

    // Add Telefone
    JPanel telefonePanel;
    JButton addTelefone;
    JButton addTelefoneConfirm;
    JTextArea addTelefoneTextArea;
    JLabel telefoneLabel;
    JTextField telefoneText;
    JButton addCancelTelefone;

    App() {
        // Layout principal
        mainFrame = new JFrame("Agenda Telefônica");
        mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        secondaryFrame = new JFrame("Agenda Telefônica - Adicionar");
        secondaryFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        panel1 = new JPanel();
        panel2 = new JPanel();
        var onButtonClicked = new OnButtonClicked();

        // MenuBar
        panelButtons = new JPanel();
        panelButtons.setLayout(new GridLayout(5, 1));

        addPessoa = new JButton("Adicionar Pessoa");
        addPessoa.addActionListener(onButtonClicked);
        panelButtons.add(addPessoa);

        addCarro = new JButton("Adicionar Carro");
        addCarro.addActionListener(onButtonClicked);
        panelButtons.add(addCarro);

        addPossui = new JButton("Registrar Proprietário");
        addPossui.addActionListener(onButtonClicked);
        panelButtons.add(addPossui);

        addTelefone = new JButton("Inserir Telefone");
        addTelefone.addActionListener(onButtonClicked);
        panelButtons.add(addTelefone);

        // Botões para escolher se a busca é por Pessoa (código) ou Carro (placa)
        buttonGroup = new ButtonGroup();
        pessoaLabel = new JLabel("Pessoa");
        isPessoa = new JCheckBox();
        isPessoa.setSelected(true);
        carroLabel = new JLabel("Carro");
        isCarro = new JCheckBox();
        buttonGroup.add(isPessoa);
        buttonGroup.add(isCarro);

        // Texto de busca e janela de resultado
        labelTextField = new JLabel("Código ou Placa");
        textField = new JTextField(10);
        querySend = new JButton("Buscar");
        querySend.addActionListener(onButtonClicked);
        textArea = new JTextArea();
        textArea.setEditable(false);

        // Posicionando elementos
        panel1.add(isPessoa);
        panel1.add(pessoaLabel);
        panel1.add(isCarro);
        panel1.add(carroLabel);

        panel2.add(labelTextField);
        panel2.add(textField);
        panel2.add(querySend);

        mainFrame.getContentPane().add(BorderLayout.EAST, panelButtons);
        mainFrame.getContentPane().add(BorderLayout.NORTH, panel1);
        mainFrame.getContentPane().add(BorderLayout.CENTER, panel2);
        mainFrame.getContentPane().add(BorderLayout.SOUTH, textArea);
        mainFrame.setSize(800, 600);
        mainFrame.setVisible(true);
        secondaryFrame.setSize(800, 600);
        secondaryFrame.setVisible(false);
    }

    class OnButtonClicked implements ActionListener {

        @Override
        public void actionPerformed(ActionEvent e) {
            if (e.getSource() == querySend) {
                String result = "";
                if (isCarro.isSelected()) {
                    String placa = textField.getText();
                    result = SelectCarro.selectByPlaca(placa);
                } else {
                    String codigo = textField.getText();
                    result = SelectPessoa.selectByCodigo(codigo);
                }
                textArea.setText(result);
            } else if (e.getSource() == addCarro) {
                setupAddCarro();
            } else if (e.getSource() == addCarroConfirm) {
                String placa = carroPlacaText.getText();
                String ano = carroAnoText.getText();
                String modelo = carroModeloText.getText();
                String cor = carroCorText.getText();
                addCarroTextArea.setText(InsertCarro.insert(placa, ano, modelo, cor));
            } else if (e.getSource() == addPossui) {
                setupAddPossui();
            } else if (e.getSource() == addPossuiConfirm) {
                String codigo = pessoaCodigoText.getText();
                String placa = carroPlacaText.getText();
                addPossuiTextArea.setText(InsertPossui.insert(codigo, placa));
            } else if (e.getSource() == addTelefone) {
                setupAddTelefone();
            } else if (e.getSource() == addTelefoneConfirm) {
                String codigo = pessoaCodigoText.getText();
                String telefone = telefoneText.getText();
                addTelefoneTextArea.setText(InsertTelefone.insert(codigo, telefone));
            } else if (e.getSource() == addPessoa) {
                setupAddPessoa();
            } else if (e.getSource() == addPessoaConfirm) {
                String codigo = pessoaCodigoText.getText();
                String nome = pessoaNomeText.getText();
                String dataNasc = pessoaDataNascText.getText();
                String homepage = pessoaHomepageText.getText();
                String cep = pessoaCepText.getText();
                String rua = pessoaRuaText.getText();
                String numero = pessoaNumeroText.getText();
                String complemento = pessoaComplementoText.getText();
                addPessoaTextArea.setText(InsertPessoa
                        .insert(codigo, nome, dataNasc, homepage, cep, rua, numero, complemento));
            } else {
                mainFrame.setVisible(true);
                secondaryFrame.setVisible(false);
                secondaryFrame = new JFrame("Agenda Telefônica - Adicionar");
                secondaryFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                secondaryFrame.setSize(800, 600);
            }
        }
    }

    private void setupAddCarro() {
        gridLayout = new GridLayout(5, 2);
        addCarroTextArea = new JTextArea();
        addCarroTextArea.setEditable(false);

        carroPanel = new JPanel();
        carroPanel.setLayout(gridLayout);

        carroPlaca = new JLabel("Placa");
        carroPlacaText = new JTextField(7);
        carroPanel.add(carroPlaca);
        carroPanel.add(carroPlacaText);

        carroAno = new JLabel("Ano");
        carroAnoText = new JTextField(4);
        carroPanel.add(carroAno);
        carroPanel.add(carroAnoText);

        carroModelo = new JLabel("Modelo");
        carroModeloText = new JTextField(25);
        carroPanel.add(carroModelo);
        carroPanel.add(carroModeloText);

        carroCor = new JLabel("Cor");
        carroCorText = new JTextField(25);
        carroPanel.add(carroCor);
        carroPanel.add(carroCorText);

        addCarroConfirm = new JButton("Adicionar");
        addCarroConfirm.addActionListener(new OnButtonClicked());
        addCancelCarro = new JButton("Cancelar");
        addCancelCarro.addActionListener(new OnButtonClicked());
        carroPanel.add(addCancelCarro);
        carroPanel.add(addCarroConfirm);

        secondaryFrame.getContentPane().add(BorderLayout.CENTER, carroPanel);
        secondaryFrame.getContentPane().add(BorderLayout.SOUTH, addCarroTextArea);

        secondaryFrame.setVisible(true);
        mainFrame.setVisible(false);
    }

    private void setupAddPossui() {
        gridLayout = new GridLayout(3, 2);
        addPossuiTextArea = new JTextArea();
        addPossuiTextArea.setEditable(false);

        possuiPanel = new JPanel();
        possuiPanel.setLayout(gridLayout);

        carroPlaca = new JLabel("Placa");
        carroPlacaText = new JTextField(7);
        possuiPanel.add(carroPlaca);
        possuiPanel.add(carroPlacaText);

        pessoaCodigo = new JLabel("Código Proprietário");
        pessoaCodigoText = new JTextField(4);
        possuiPanel.add(pessoaCodigo);
        possuiPanel.add(pessoaCodigoText);

        addPossuiConfirm = new JButton("Registrar");
        addPossuiConfirm.addActionListener(new OnButtonClicked());
        addCancelPossui = new JButton("Cancelar");
        addCancelPossui.addActionListener(new OnButtonClicked());
        possuiPanel.add(addCancelPossui);
        possuiPanel.add(addPossuiConfirm);

        secondaryFrame.getContentPane().add(BorderLayout.CENTER, possuiPanel);
        secondaryFrame.getContentPane().add(BorderLayout.SOUTH, addPossuiTextArea);

        secondaryFrame.setVisible(true);
        mainFrame.setVisible(false);
    }
    
    private void setupAddPessoa() {
        gridLayout = new GridLayout(9, 2);
        addPessoaTextArea = new JTextArea();
        addPessoaTextArea.setEditable(false);

        pessoaPanel = new JPanel();
        pessoaPanel.setLayout(gridLayout);

        pessoaCodigo = new JLabel("Código");
        pessoaCodigoText = new JTextField(5);
        pessoaPanel.add(pessoaCodigo);
        pessoaPanel.add(pessoaCodigoText);

        pessoaNome = new JLabel("Nome");
        pessoaNomeText = new JTextField(100);
        pessoaPanel.add(pessoaNome);
        pessoaPanel.add(pessoaNomeText);            
        
        pessoaDataNasc = new JLabel("Data de Nascimento");
        pessoaDataNascText = new JTextField(100);
        pessoaPanel.add(pessoaDataNasc);
        pessoaPanel.add(pessoaDataNascText);
        
        pessoaHomepage = new JLabel("Homepage");
        pessoaHomepageText = new JTextField(100);
        pessoaPanel.add(pessoaHomepage);
        pessoaPanel.add(pessoaHomepageText);
        
        pessoaCep = new JLabel("Cep");
        pessoaCepText = new JTextField(9);
        pessoaPanel.add(pessoaCep);
        pessoaPanel.add(pessoaCepText);
        
        pessoaRua = new JLabel("Rua");
        pessoaRuaText = new JTextField(100);
        pessoaPanel.add(pessoaRua);
        pessoaPanel.add(pessoaRuaText);
        
        pessoaNumero = new JLabel("Numero");
        pessoaNumeroText = new JTextField(6);
        pessoaPanel.add(pessoaNumero);
        pessoaPanel.add(pessoaNumeroText);
        
        pessoaComplemento = new JLabel("Complemento");
        pessoaComplementoText = new JTextField(100);
        pessoaPanel.add(pessoaComplemento);
        pessoaPanel.add(pessoaComplementoText);

        addPessoaConfirm = new JButton("Registrar");
        addPessoaConfirm.addActionListener(new OnButtonClicked());
        addCancelPessoa = new JButton("Cancelar");
        addCancelPessoa.addActionListener(new OnButtonClicked());
        pessoaPanel.add(addCancelPessoa);
        pessoaPanel.add(addPessoaConfirm);

        secondaryFrame.getContentPane().add(BorderLayout.CENTER, pessoaPanel);
        secondaryFrame.getContentPane().add(BorderLayout.SOUTH, addPessoaTextArea);

        secondaryFrame.setVisible(true);
        mainFrame.setVisible(false);
    }

    private void setupAddTelefone() {
        gridLayout = new GridLayout(3, 2);
        addTelefoneTextArea = new JTextArea();
        addTelefoneTextArea.setEditable(false);

        telefonePanel = new JPanel();
        telefonePanel.setLayout(gridLayout);

        pessoaCodigo = new JLabel("Código dono do telefone");
        pessoaCodigoText = new JTextField(4);
        telefonePanel.add(pessoaCodigo);
        telefonePanel.add(pessoaCodigoText);

        telefoneLabel = new JLabel("Telefone");
        telefoneText = new JTextField(15);
        telefonePanel.add(telefoneLabel);
        telefonePanel.add(telefoneText);

        addTelefoneConfirm = new JButton("Registrar");
        addTelefoneConfirm.addActionListener(new OnButtonClicked());
        addCancelTelefone = new JButton("Cancelar");
        addCancelTelefone.addActionListener(new OnButtonClicked());
        telefonePanel.add(addCancelTelefone);
        telefonePanel.add(addTelefoneConfirm);

        secondaryFrame.getContentPane().add(BorderLayout.CENTER, telefonePanel);
        secondaryFrame.getContentPane().add(BorderLayout.SOUTH, addTelefoneTextArea);

        secondaryFrame.setVisible(true);
        mainFrame.setVisible(false);
    }
}
