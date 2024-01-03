addi s1, zero, 5
addi t0, zero, 0
addi t1, zero, 1
addi t2, s1, 0

factorial:
    beq     s1, t0, done
    beq     s1, t1, done
    addi    s2, s1, -1
    beq     s2, t1, done
    addi    t3, t2, 0
    mul:
        add     t2, t2, t3
        addi    s2, s2, -1
        bne     s2, t1, mul
        addi    s1, s1, -1
        j       factorial
done:       
