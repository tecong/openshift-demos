package com.tieto.teco.openshiftdemos.microservicedemo.demoapp.repository.search;

import com.tieto.teco.openshiftdemos.microservicedemo.demoapp.domain.User;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data ElasticSearch repository for the User entity.
 */
public interface UserSearchRepository extends ElasticsearchRepository<User, Long> {
}
