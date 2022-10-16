package com.thes2k.stockmanager.repository;

import com.thes2k.stockmanager.model.Compte;
import com.thes2k.stockmanager.model.Etat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CompteRepository extends JpaRepository<Compte, Long> {
    @Query("select compte from Compte compte where compte.email = :param or compte.phone = :param or compte.username = :param")
    Compte findCompteByEmailOrPhoneOrUsername(@Param("param") String usernameOrEmailOrphone);

    List<Compte> findCompteByEtat(Etat etat);
}
