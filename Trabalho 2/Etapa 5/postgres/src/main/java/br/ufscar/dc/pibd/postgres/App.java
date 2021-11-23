package br.ufscar.dc.pibd.postgres;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class App {
    JFrame mainFrame;
    JFrame secondaryFrame;
    GridLayout gridLayout;
    JButton addCancel;

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

    // Add Pessoa
    JLabel pessoaCodigo;
    JTextField pessoaCodigoText;

    // Add Possui
    JPanel possuiPanel;
    JButton addPossui;
    JButton addPossuiConfirm;
    JTextArea addPossuiTextArea;

    App() {
        // Layout principal
        mainFrame = new JFrame("Agenda Telefônica");
        mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        secondaryFrame = new JFrame("Agenda Telefônica - Adicionar");
        secondaryFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        panel1 = new JPanel();
        panel2 = new JPanel();
        var onButtonClicked = new OnButtonClicked();
        addCancel = new JButton("Cancelar");
        addCancel.addActionListener(onButtonClicked);

        // MenuBar
        panelButtons = new JPanel();
        panelButtons.setLayout(new GridLayout(5, 1));

        addCarro = new JButton("Adicionar Carro");
        addCarro.addActionListener(onButtonClicked);
        panelButtons.add(addCarro);

        addPossui = new JButton("Registrar Proprietário");
        addPossui.addActionListener(onButtonClicked);
        panelButtons.add(addPossui);

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
            } else if (e.getSource() == addCancel) {
                mainFrame.setVisible(true);
                secondaryFrame.setVisible(false);
                secondaryFrame.dispose();
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
            }
        }
    }

    private void setupAddCarro() {
        secondaryFrame.dispose();
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
        carroPanel.add(addCancel);
        carroPanel.add(addCarroConfirm);

        secondaryFrame.getContentPane().add(BorderLayout.CENTER, carroPanel);
        secondaryFrame.getContentPane().add(BorderLayout.SOUTH, addCarroTextArea);

        secondaryFrame.setVisible(true);
        mainFrame.setVisible(false);
    }

    private void setupAddPossui() {
        secondaryFrame.dispose();
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
        possuiPanel.add(addCancel);
        possuiPanel.add(addPossuiConfirm);

        secondaryFrame.getContentPane().add(BorderLayout.CENTER, possuiPanel);
        secondaryFrame.getContentPane().add(BorderLayout.SOUTH, addPossuiTextArea);

        secondaryFrame.setVisible(true);
        mainFrame.setVisible(false);
    }
}
