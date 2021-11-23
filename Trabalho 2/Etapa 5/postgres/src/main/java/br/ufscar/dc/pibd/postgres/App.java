package br.ufscar.dc.pibd.postgres;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class App {
    JFrame mainFrame;

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

    App() {
        // Layout principal
        mainFrame = new JFrame("Agenda Telefônica");
        mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        panel1 = new JPanel();
        panel2 = new JPanel();

        // MenuBar
        panelButtons = new JPanel();
        addCarro = new JButton("Adicionar Carro");
        panelButtons.add(addCarro);

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
        var onButtonClicked = new OnButtonClicked();
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
        mainFrame.setSize(600, 400);
        mainFrame.setVisible(true);
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
            }
        }
    }
}
