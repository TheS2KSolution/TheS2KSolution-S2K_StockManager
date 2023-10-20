package com.eschool.backend.validation;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class ValidationMapper {
    public ValidationDTO toDTO(Validation validation) {
        if (validation == null) {
            return null;
        }
        ValidationDTO validationDTO = new ValidationDTO();
        BeanUtils.copyProperties(validation, validationDTO);
        return validationDTO;
    }

    public Validation toEntity(ValidationDTO validationDTO) {
        if (validationDTO == null) {
            return null;
        }
        Validation validation = new Validation();
        BeanUtils.copyProperties(validationDTO, validation);
        return validation;
    }

}
