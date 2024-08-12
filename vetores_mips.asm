.data
    prompt:      .asciiz "Digite um número: "  # Mensagem para solicitar entrada do usuário
    array:       .space 20                    # Espaço reservado para armazenar 20 bytes, 5 inteiros

.text
    main:
        # Inicializa o índice do vetor
        li $t0, 0          # $t0 será o índice do array

    read_numbers:
        # Verifica se já foram lidos 5 números
        li $t1, 5          # $t1 armazena o número de elementos ainda a ser lido
        bge $t0, $t1, end  # Se $t0 >= $t1 vai para o fim

        # Exibe a mensagem de solicitação de entrada
        li $v0, 4          # Código de serviço para print_string
        la $a0, prompt     # Mensagem a ser exibida
        syscall

        # Lê um número inteiro do usuário
        li $v0, 5          # Código de serviço para read_int
        syscall
        move $t2, $v0      # Armazena o número lido em $t2

        # Armazena o número lido no array
        la $t3, array      # Carrega o endereço base do array em $t3
        sll $t4, $t0, 2    # Calcula o deslocamento do array
        add $t3, $t3, $t4  # Adiciona o deslocamento ao endereço base
        sw $t2, 0($t3)     # Armazena o número em $t2

        # Incrementa o índice do vetor
        addi $t0, $t0, 1   # Incrementa $t0 por 1
        j read_numbers     # Volta para ler o próximo número

    end:
        li $v0, 10
        syscall