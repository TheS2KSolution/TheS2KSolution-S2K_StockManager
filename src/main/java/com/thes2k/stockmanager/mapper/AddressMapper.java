package com.thes2k.stockmanager.mapper;

import com.thes2k.stockmanager.dto.AddressDto;
import com.thes2k.stockmanager.model.Address;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

@Service
public class AddressMapper {


    public AddressDto toEntity(Address address) {
        AddressDto addressDto = new AddressDto();
        BeanUtils.copyProperties(address, addressDto);
        return addressDto;
    }

    public Address fromEntity(AddressDto addressDto) {
        Address address = new Address();
        BeanUtils.copyProperties(addressDto, address);
        return address;
    }
}
