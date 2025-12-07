package cz.osslite.demo.oauth2.server.domain.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.springframework.data.jpa.domain.AbstractPersistable;

import java.time.LocalDate;

@Entity
//@jakarta.persistence.Entity
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@Table(name = "customer")
@SequenceGenerator(name = "sequence_cust", sequenceName = "sq_cust_id", allocationSize = 1)
public class Customer extends AbstractPersistable<Long> {
    @Id
    @GeneratedValue(generator = "sequence_cust", strategy = GenerationType.SEQUENCE)
    @Column(name = "id", nullable = false)
    private Long id;

    @NotNull
    @Column(name = "first_name", length = 200)
    private String firstName;

    @Column(name = "middle_name", length = 200)
    private String middleName;

    @NotNull
    @Column(name = "last_name", length = 200)
    private String lastName;

    @Column(name = "email", length = 500)
    private String email;

    @Column(name = "phone_number", length = 20)
    private String phoneNumber;

    @Column(name = "birth_date")
    private LocalDate birthDate;
}