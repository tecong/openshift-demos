package com.tieto.teco.openshiftdemos.microservicedemo.repository.repository.search;

import com.tieto.teco.openshiftdemos.microservicedemo.repository.domain.Product;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data ElasticSearch repository for the Product entity.
 */
public interface ProductSearchRepository extends ElasticsearchRepository<Product, Long> {
}
