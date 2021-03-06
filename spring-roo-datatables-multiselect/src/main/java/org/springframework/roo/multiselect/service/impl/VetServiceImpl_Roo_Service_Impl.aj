// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.springframework.roo.multiselect.service.impl;

import io.springlets.data.domain.GlobalSearch;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.roo.multiselect.domain.Vet;
import org.springframework.roo.multiselect.domain.Visit;
import org.springframework.roo.multiselect.repository.VetRepository;
import org.springframework.roo.multiselect.service.api.VetService;
import org.springframework.roo.multiselect.service.api.VisitService;
import org.springframework.roo.multiselect.service.impl.VetServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

privileged aspect VetServiceImpl_Roo_Service_Impl {
    
    declare parents: VetServiceImpl implements VetService;
    
    declare @type: VetServiceImpl: @Service;
    
    declare @type: VetServiceImpl: @Transactional(readOnly = true);
    
    /**
     * TODO Auto-generated attribute documentation
     */
    private VetRepository VetServiceImpl.vetRepository;
    
    /**
     * TODO Auto-generated attribute documentation
     */
    private VisitService VetServiceImpl.visitService;
    
    /**
     * TODO Auto-generated constructor documentation
     * 
     * @param vetRepository
     * @param visitService
     */
    @Autowired
    public VetServiceImpl.new(VetRepository vetRepository, @Lazy VisitService visitService) {
        this.vetRepository = vetRepository;
        this.visitService = visitService;
    }

    /**
     * TODO Auto-generated method documentation
     * 
     * @param vet
     * @param visitsToAdd
     * @return Vet
     */
    @Transactional
    public Vet VetServiceImpl.addToVisits(Vet vet, Iterable<Long> visitsToAdd) {
        List<Visit> visits = visitService.findAll(visitsToAdd);
        vet.addToVisits(visits);
        return vetRepository.save(vet);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param vet
     * @param visitsToRemove
     * @return Vet
     */
    @Transactional
    public Vet VetServiceImpl.removeFromVisits(Vet vet, Iterable<Long> visitsToRemove) {
        List<Visit> visits = visitService.findAll(visitsToRemove);
        vet.removeFromVisits(visits);
        return vetRepository.save(vet);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param vet
     * @param visits
     * @return Vet
     */
    @Transactional
    public Vet VetServiceImpl.setVisits(Vet vet, Iterable<Long> visits) {
        List<Visit> items = visitService.findAll(visits);
        Set<Visit> currents = vet.getVisits();
        Set<Visit> toRemove = new HashSet<Visit>();
        for (Iterator<Visit> iterator = currents.iterator(); iterator.hasNext();) {
            Visit nextVisit = iterator.next();
            if (items.contains(nextVisit)) {
                items.remove(nextVisit);
            } else {
                toRemove.add(nextVisit);
            }
        }
        vet.removeFromVisits(toRemove);
        vet.addToVisits(items);
        return vetRepository.save(vet);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param vet
     */
    @Transactional
    public void VetServiceImpl.delete(Vet vet) {
        // Clear bidirectional one-to-many parent relationship with Visit
        for (Visit item : vet.getVisits()) {
            item.setVet(null);
        }
        
        vetRepository.delete(vet);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param entities
     * @return List
     */
    @Transactional
    public List<Vet> VetServiceImpl.save(Iterable<Vet> entities) {
        return vetRepository.save(entities);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param ids
     */
    @Transactional
    public void VetServiceImpl.delete(Iterable<Long> ids) {
        List<Vet> toDelete = vetRepository.findAll(ids);
        vetRepository.deleteInBatch(toDelete);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param entity
     * @return Vet
     */
    @Transactional
    public Vet VetServiceImpl.save(Vet entity) {
        return vetRepository.save(entity);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param id
     * @return Vet
     */
    public Vet VetServiceImpl.findOne(Long id) {
        return vetRepository.findOne(id);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param ids
     * @return List
     */
    public List<Vet> VetServiceImpl.findAll(Iterable<Long> ids) {
        return vetRepository.findAll(ids);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @return List
     */
    public List<Vet> VetServiceImpl.findAll() {
        return vetRepository.findAll();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @return Long
     */
    public long VetServiceImpl.count() {
        return vetRepository.count();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param globalSearch
     * @param pageable
     * @return Page
     */
    public Page<Vet> VetServiceImpl.findAll(GlobalSearch globalSearch, Pageable pageable) {
        return vetRepository.findAll(globalSearch, pageable);
    }
    
}
