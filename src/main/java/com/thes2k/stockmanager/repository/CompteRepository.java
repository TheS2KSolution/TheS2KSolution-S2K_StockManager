package com.thes2k.stockmanager.repository;

import com.thes2k.stockmanager.model.Compte;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CompteRepository extends JpaRepository<Compte, Long> {
    @Query("select compte from Compte compte where compte.email = :param or compte.phone = :param or compte.username = :param")
    Compte findCompteByEmailOrPhoneOrUsername(@Param("param") String usernameOrEmailOrPhone);
    Compte findByUsername(String username);
    Compte findByEmail(String email);
    Compte findByPhone(String phone);

    //List<Compte> findCompteByEtat(Etat_Compte etatCompte);
}
